class RoomBedsController < ApplicationController
  before_action :set_room_bed, only: %i[ show edit update destroy ]

  # GET /room_beds or /room_beds.json
  def index
    @room_beds = RoomBed.all
  end

  # GET /room_beds/1 or /room_beds/1.json
  def show
  end

  # GET /room_beds/new
  def new
    @room_bed = RoomBed.new
  end

  # GET /room_beds/1/edit
  def edit
  end

  # POST /room_beds or /room_beds.json
  def create
    @room_bed = RoomBed.new(room_bed_params)

    respond_to do |format|
      if @room_bed.save
        format.html { redirect_to room_bed_url(@room_bed), notice: "Room bed was successfully created." }
        format.json { render :show, status: :created, location: @room_bed }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @room_bed.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /room_beds/1 or /room_beds/1.json
  def update
    respond_to do |format|
      if @room_bed.update(room_bed_params)
        format.html { redirect_to room_bed_url(@room_bed), notice: "Room bed was successfully updated." }
        format.json { render :show, status: :ok, location: @room_bed }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @room_bed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /room_beds/1 or /room_beds/1.json
  def destroy
    @room_bed.destroy!

    respond_to do |format|
      format.html { redirect_to room_beds_url, notice: "Room bed was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room_bed
      @room_bed = RoomBed.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def room_bed_params
      params.require(:room_bed).permit(:room_id, :bed_id)
    end
end
