class RoomServicesController < ApplicationController
  before_action :set_room_service, only: %i[ show edit update destroy ]

  # GET /room_services or /room_services.json
  def index
    @room_services = RoomService.all
  end

  # GET /room_services/1 or /room_services/1.json
  def show
  end

  # GET /room_services/new
  def new
    @room_service = RoomService.new
  end

  # GET /room_services/1/edit
  def edit
  end

  # POST /room_services or /room_services.json
  def create
    @room_service = RoomService.new(room_service_params)

    respond_to do |format|
      if @room_service.save
        format.html { redirect_to room_service_url(@room_service), notice: "Room service was successfully created." }
        format.json { render :show, status: :created, location: @room_service }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @room_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /room_services/1 or /room_services/1.json
  def update
    respond_to do |format|
      if @room_service.update(room_service_params)
        format.html { redirect_to room_service_url(@room_service), notice: "Room service was successfully updated." }
        format.json { render :show, status: :ok, location: @room_service }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @room_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /room_services/1 or /room_services/1.json
  def destroy
    @room_service.destroy!

    respond_to do |format|
      format.html { redirect_to room_services_url, notice: "Room service was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room_service
      @room_service = RoomService.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def room_service_params
      params.require(:room_service).permit(:room_id, :service_id)
    end
end
