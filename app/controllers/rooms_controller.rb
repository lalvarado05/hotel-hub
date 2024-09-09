class RoomsController < ApplicationController
  include RoomsHelper
  before_action :set_room, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show, :search]  # Devise authentication
  load_and_authorize_resource  # CanCanCan for authorization

  # GET /rooms or /rooms.json
  def index
    @rooms = Room.all
  end

  # GET /rooms/1 or /rooms/1.json
  def show
  end

  # GET /rooms/new
  def new
    @room = Room.new
    @beds = Bed.all
    @services = Service.all
  end

  # GET /rooms/1/edit
  def edit
    @beds = Bed.all
    @services = Service.all
  end

  # POST /rooms or /rooms.json
  def create
    @room = Room.new(room_params)
    @current_user = current_user
    respond_to do |format|
      if @room.save
        # UserNotifierJob.perform_async(@current_user.id, @room.id)  # Could not configure sidekiq
        RoomMailer.created_room(@room, @current_user).deliver_now            # This for now until sidekiq is configured
        if params[:room][:bed_ids].present?
          params[:room][:bed_ids].each do |bed_id|
            RoomBed.find_or_create_by!(room: @room, bed_id: bed_id)
          end
        end

        if params[:room][:service_ids].present?
          params[:room][:service_ids].each do |service_id|
            RoomService.find_or_create_by!(room: @room, service_id: service_id)
          end
        end

        format.html { redirect_to rooms_url, notice: "Room was successfully created." }
        format.json { render :show, status: :created, location: @room }
      else
        @beds = Bed.all
        @services = Service.all
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1 or /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        # Clear existing room_beds and room_services
        @room.room_beds.destroy_all
        @room.room_services.destroy_all

        # Handle beds
        if params[:room][:bed_ids].present?
          params[:room][:bed_ids].each do |bed_id|
            RoomBed.create(room: @room, bed_id: bed_id)
          end
        end

        # Handle services
        if params[:room][:service_ids].present?
          params[:room][:service_ids].each do |service_id|
            RoomService.create(room: @room, service_id: service_id)
          end
        end

        format.html { redirect_to room_url(@room), notice: "Room was successfully updated." }
        format.json { render :show, status: :ok, location: @room }
      else
        @beds = Bed.all
        @services = Service.all
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1 or /rooms/1.json
  def destroy
    @room.destroy!

    respond_to do |format|
      format.html { redirect_to rooms_url, notice: "Room was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # Search for available rooms
  def search
    set_dates
    validate_dates

    # Load all services for filter section
    @services = Service.all

    # Get the maximum price for the price range filter
    @max_price = Room.maximum(:price) || 200

    @rooms = filter_rooms_by_capacity_and_availability

    apply_price_range_filter
    apply_service_filter
    apply_sorting

    @no_rooms_found = @rooms.empty?
    render :search
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_room
    @room = Room.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def room_params
    params.require(:room).permit(:name, :price, :available, :image, bed_ids: [], service_ids: [])
  end

  # Check if room is available
  def room_available?(room, check_in_date, check_out_date)
    reservations = room.reservations.where(
      "(check_in_date < ? AND check_out_date > ?) OR (check_in_date >= ? AND check_in_date < ?)",
      check_out_date, check_in_date, check_in_date, check_out_date
    )
    reservations.empty?
  end

  def set_dates
    @check_in_date = params[:check_in_date].present? ? Date.parse(params[:check_in_date]) : Date.today
    @check_out_date = params[:check_out_date].present? ? Date.parse(params[:check_out_date]) : Date.tomorrow
    @guest_amount = params[:guest_amount].to_i > 0 ? params[:guest_amount].to_i : 1
  end

  def validate_dates
    if @check_in_date < Date.today
      flash[:alert] = "Check-in date cannot be in the past."
      render :search and return
    end

    if @check_out_date <= @check_in_date
      flash[:alert] = "Check-out date must be after the check-in date."
      render :search and return
    end
  end

  def filter_rooms_by_capacity_and_availability
    Room.all.select do |room|
      room.capacity >= @guest_amount && room_available?(room, @check_in_date, @check_out_date)
    end
  end

  def apply_price_range_filter
    return unless params[:price_range].present?

    price_limit = params[:price_range].to_i
    @rooms = @rooms.select { |room| room.price <= price_limit }
  end

  def apply_service_filter
    return unless params[:services].present?

    selected_service_ids = params[:services].map(&:to_i)
    @rooms = @rooms.select { |room| (room.service_ids & selected_service_ids).sort == selected_service_ids.sort }
  end

  def apply_sorting
    return unless params[:sort_by].present?

    case params[:sort_by]
    when "price_asc"
      @rooms = @rooms.sort_by(&:price)
    when "price_desc"
      @rooms = @rooms.sort_by(&:price).reverse
    when "capacity_asc"
      @rooms = @rooms.sort_by(&:capacity)
    when "capacity_desc"
      @rooms = @rooms.sort_by(&:capacity).reverse
    end
  end
  


end
