class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[ show edit update destroy ]
  before_action :authenticate_user!  # Devise authentication
  before_action :set_room, only: [:new, :create]


  # GET /reservations or /reservations.json
  def index
    @reservations = Reservation.all
  end

  # GET /reservations/1 or /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
    @room = Room.find(params[:room_id])
    @check_in_date = params[:check_in_date]
    @check_out_date = params[:check_out_date]
    @user = current_user
  end


  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations or /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user = current_user
    @reservation.room = Room.find(params[:reservation][:room_id])
    @reservation.status = "booked"
    @reservation.confirmation_code = "#{@reservation.user.id}-#{@reservation.room.id}-#{Date.today.strftime('%Y%m%d')}"
    
    # Capture check-in, check-out, and payment details
    @check_in_date = params[:reservation][:check_in_date]
    @check_out_date = params[:reservation][:check_out_date]
    @card_number = params[:card_number]
    @exp_date = params[:exp_date]
    @security_code = params[:security_code]

    respond_to do |format|
      # Validate payment information
      payment_errors = valid_payment_info?(@card_number, @exp_date, @security_code)

      if payment_errors == true
        if @reservation.save
          format.html { redirect_to reservation_url(@reservation), notice: "Reservation was successfully created." }
          format.json { render :show, status: :created, location: @reservation }
        else

          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @reservation.errors, status: :unprocessable_entity }
        end
      else
        flash[:alert] = "Invalid payment information. Please check your card details."
        @payment_errors = payment_errors
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { error: "Invalid payment information" }, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1 or /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to reservation_url(@reservation), notice: "Reservation was successfully updated." }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1 or /reservations/1.json
  def destroy
    @reservation.destroy!

    respond_to do |format|
      format.html { redirect_to reservations_url, notice: "Reservation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reservation_params
      params.require(:reservation).permit(:user_id, :room_id, :check_in_date, :check_out_date, :status)
    end

    def set_room
      @room = Room.find_by(id: params[:room_id]) || Room.find_by(id: params[:reservation][:room_id])
    end

     # Payment validation methods
    def valid_payment_info?(card_number, exp_date, security_code)
      errors = {}

      unless valid_card_number?(card_number)
        errors[:card_number] = "Card number must be 16 digits long and contain only numbers."
      end

      unless valid_exp_date?(exp_date)
        errors[:exp_date] = "Expiration date must be in the format MM/YY and must be a valid month."
      end

      unless valid_security_code?(security_code)
        errors[:security_code] = "Security code must be 3 digits long and contain only numbers."
      end

      errors.empty? ? true : errors
    end

    def valid_card_number?(card_number)
      card_number.length == 16 && card_number.scan(/\D/).empty?
    end

    def valid_exp_date?(exp_date)
      exp_date.match?(/^(0[1-9]|1[0-2])\/[0-9]{2}$/)
    end

    def valid_security_code?(security_code)
      security_code.length == 3 && security_code.scan(/\D/).empty?
    end
end
