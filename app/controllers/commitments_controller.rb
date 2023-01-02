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
    @groupinfo = Groupinfo.find(params[:group_id])
    @users = User.where(id: params[:user_ids])
    @commitment = @groupinfo.commitments.new(commitmentdesc: params[:commitmentdesc],
                                             commitmentamount: params[:commitmentamount],
                                             occurancedate: params[:occurancedate],
                                             expirationdate: params[:expirationdate])
    @commitment.users = @users
    if @commitment.save
      render json: @commitment, status: :ok
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
