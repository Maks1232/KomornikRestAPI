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
    # Pobierz identyfikator zobowiązania z ciała żądania
    commitment_id = JSON.parse(request.body.read)['commitment_id']
    if commitment_id.nil?
      render json: { error: "Missing commitment_id parameter" }, status: :bad_request
      return
    end

    # Pobierz obiekt zobowiązania o podanym identyfikatorze
    @commitment = Commitment.find_by(id: commitment_id)
    if @commitment.nil?
      render json: { error: "Commitment with id #{commitment_id} not found" }, status: :not_found
      return
    end

    # Pobierz tablicę z identyfikatorami użytkowników i kwotami rachunków z ciała żądania
    bills_params = params[:bills]

    # Iteruj przez tablicę bills_params i twórz nowe rachunki dla każdego użytkownika
    bills = []
    amount_sum = 0
    bills_params.each do |bills_params|
      user_id = bills_params[:user_id]
      amount = bills_params[:amount]

      # Utwórz nowy rachunek dla użytkownika o podanym identyfikatorze i kwocie
      bill = Bill.new(user_id: user_id, amount: amount)
      bills << bill
      amount_sum += bill.amount
    end

    # Sprawdź, czy suma rachunków jest równa wartości zobowiązania
    if amount_sum == @commitment.commitmentamount
      # Jeśli tak, zapisz rachunki do bazy danych
      bills.each do |bill|
        bill.save
      end
      # Zwróć odpowiedź z listą utworzonych rachunków
      render json: bills, status: :ok
    else
      # Jeśli suma rachunków nie jest równa wartości zobowiązania, zwróć błąd
      render json: { error: "Total amount of bills must be equal to commitment amount" }, status: :unprocessable_entity
    end
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
