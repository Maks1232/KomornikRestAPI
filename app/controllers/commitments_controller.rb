class CommitmentsController < ApplicationController
  before_action :set_commitment, only: %i[ show update destroy ]

  # GET /commitments
  def index
    @commitments = Commitment.all

    render json: @commitments
  end

  # GET /commitments/1
  def show
    render json: @commitment
  end

  # POST /commitments
  def create
    @commitment = Commitment.new(commitment_params)

    if @commitment.save
      render json: @commitment, status: :created, location: @commitment
    else
      render json: @commitment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /commitments/1
  def update
    if @commitment.update(commitment_params)
      render json: @commitment
    else
      render json: @commitment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /commitments/1
  def destroy
    @commitment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_commitment
      @commitment = Commitment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def commitment_params
      params.require(:commitment).permit(:commitmentdesc, :commitmentamount, :occurancedate, :expirationdate)
    end
end
