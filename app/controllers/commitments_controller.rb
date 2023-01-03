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
    commitment_id = JSON.parse(request.body.read)['commitment_id']
    @commitment = Commitment.find_by(id: commitment_id)

    #@commitment = Commitment.find(params[:commitment_id])

    if @commitment.update(commitment_params)
      render json: @commitment
    else
      render json: @commitment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /commitments/1
  def destroy
    set_commitment
    if @commitment.destroy
      render json: { message: 'Commitment deleted!' }, status: :ok
    else
      render json: @commitment.errors, status: :unprocessable_entity
    end

  end

  def split
    # Pobierz zobowiązanie o podanym identyfikatorze
    commitment = Commitment.find(params[:id])

    # Pobierz tablicę z identyfikatorami użytkowników i kwotami rachunków z ciała żądania
    bills_params = params[:bills]

    # Iteruj przez tablicę debts_params i twórz nowe rachunki dla każdego użytkownika
    bills_params.each do |bills_params|
      user_id = bills_params[:user_id]
      amount = bills_params[:amount]

      # Utwórz nowy rachunek dla użytkownika o podanym identyfikatorze i kwocie
      bill = Bill.create(commitment: commitment, user_id: user_id, amount: amount)
    end

    # Zwróć odpowiedź z listą utworzonych rachunków
    render json: commitment.bills, status: :ok
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
