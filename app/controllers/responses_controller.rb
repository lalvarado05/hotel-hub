class ResponsesController < ApplicationController
  before_action :set_response, only: %i[ show edit update destroy ]
  before_action :set_review, only: %i[ new create ]
  before_action :ensure_single_response, only: %i[ new create ]
  
  # GET /responses or /responses.json
  def index
    @responses = Response.all
  end

  # GET /responses/1 or /responses/1.json
  def show
  end

  # GET /responses/new
  def new
    @response = @review.build_response
  end

  # GET /responses/1/edit
  def edit
  end

  # POST /responses or /responses.json
  def create
    @response = @review.build_response(response_params)
    @response.user = current_user

    respond_to do |format|
      if @response.save
        format.html { redirect_to responses_url, notice: "Response was successfully created." }
        format.json { render :show, status: :created, location: @response }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /responses/1 or /responses/1.json
  def update
    respond_to do |format|
      if @response.update(response_params)
        format.html { redirect_to responses_url, notice: "Response was successfully updated." }
        format.json { render :show, status: :ok, location: @response }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /responses/1 or /responses/1.json
  def destroy
    @response.destroy!

    respond_to do |format|
      format.html { redirect_to responses_url, notice: "Response was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_response
      @response = Response.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def response_params
      params.require(:response).permit(:user_id, :review_id, :comment)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:review_id])
    end

    # Only one response per review
    def ensure_single_response
      if @review.response.present?
        respond_to do |format|
          format.html { redirect_to reviews_url, alert: "This review already has a response." }
          format.json { render json: { error: "This review already has a response." }, status: :unprocessable_entity }
        end
      end
    end

end
