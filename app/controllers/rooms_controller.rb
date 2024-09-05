class RoomsController < ApplicationController
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

    respond_to do |format|
      if @room.save
        # Create room_beds and room_services
        if params[:room][:bed_ids].present?

          params[:room][:bed_ids].each do |bed_id|
            RoomBed.find_or_create_by!(room: @room, bed_id: bed_id)
          end
        end

        # Handle services
        if params[:room][:service_ids].present?
          params[:room][:service_ids].each do |service_id|
            RoomService.find_or_create_by!(room: @room, service_id: service_id)
          end
        end

        format.html { redirect_to room_url(@room), notice: "Room was successfully created." }
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

  # Custom search action
  def search
    @rooms = Room.all
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
