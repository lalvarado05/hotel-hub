class ReviewsController < ApplicationController
  before_action :set_review, only: %i[ show edit update destroy]
  before_action :set_reservation, only: %i[ new create ]
  before_action :ensure_checked_out_reservation, only: %i[ new create ]
  load_and_authorize_resource
  # GET /reviews or /reviews.json
  def index
    @reviews = Review.all
  end

  # GET /reviews/1 or /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @review = @reservation.build_review
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews or /reviews.json
  def create
    @review = @reservation.build_review(review_params)
    @review.user = current_user
    respond_to do |format|
      if @review.save
        format.html { redirect_to reservations_url, notice: "Review was successfully created." }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to reviews_url, notice: "Review was successfully updated." }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    @review.destroy!

    respond_to do |format|
      format.html { redirect_to reviews_url, notice: "Review was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:user_id, :rating, :comment, :display)
    end

    # Ensure that the user has checked out before leaving a review
    def ensure_checked_out_reservation
      unless @reservation.can_leave_review?
        respond_to do |format|
          format.html { redirect_to reservations_url, alert: "You can only leave a review after your stay." }
          format.json { render json: { error: "You can only leave a review after your stay." }, status: :unprocessable_entity }
        end
      end
    end

    # Find the reservation that the review is for
    def set_reservation
      @reservation = Reservation.find(params[:reservation_id])
    end

end
