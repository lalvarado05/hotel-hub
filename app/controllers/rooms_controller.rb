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
    @check_in_date = params[:check_in_date].present? ? Date.parse(params[:check_in_date]) : Date.today
    @check_out_date = params[:check_out_date].present? ? Date.parse(params[:check_out_date]) : Date.tomorrow
    @guest_amount = params[:guest_amount] || 1

    @rooms = Room.all.select do |room|
      room_available?(room, @check_in_date, @check_out_date)
    end

    @rooms = Room.joins(:beds).group("rooms.id").having("SUM(beds.capacity) >= ?", @guest_amount)

    # If no rooms match the criteria
    @no_rooms_found = @rooms.empty?

    render :search

  end

  # Check if room is available
  def room_available?(room, check_in_date, check_out_date)
    reservations = room.reservations.where(
      "check_in_date < ? AND check_out_date > ?",
      check_out_date, check_in_date
    )
    reservations.empty?
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



end
