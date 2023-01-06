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
      # Pobierz identyfikator grupy z ciała żądania
      group_id = params[:group_id]
      if group_id.nil?
        render json: { error: "Missing group_id parameter" }, status: :bad_request
        return
      end
      # Pobierz identyfikator użytkownika wystawiającego zobowiązanie z ciała żądania
      user_id = params[:user_id]
      if user_id.nil?
        render json: { error: "Missing user_id parameter" }, status: :bad_request
        return
      end

      # Pobierz obiekt grupy o podanym identyfikatorze
      @groupinfo = Groupinfo.find_by(id: group_id)
      if @groupinfo.nil?
        render json: { error: "Group with given id not found" }, status: :not_found
        return
      end

      @user = User.find_by(id: user_id)
      if @user.nil?
        render json: { error: "User with given id not found" }, status: :not_found
        return
      end

      # Pobierz pozostałe parametry z ciała żądania

      commitmentamount = JSON.parse(request.body.read)['commitmentamount']
      commitmentdesc = JSON.parse(request.body.read)['commitmentdesc']
      occurancedate = JSON.parse(request.body.read)['occurancedate']
      expirationdate = JSON.parse(request.body.read)['expirationdate']

      # Utwórz nowe zobowiązanie z podanymi parametrami i dodaj je do grupy
      @commitment = Commitment.new(commitmentdesc: commitmentdesc,
                                   commitmentamount: commitmentamount,
                                   occurancedate: occurancedate,
                                   expirationdate: expirationdate,
                                   groupinfo_id: @groupinfo.id,
                                   user_id: @user.id)
      if @commitment.save
        # Jeśli zapis się powiódł, zwróć odpowiedź z nowym zobowiązaniem
        render json: @commitment, status: :created
      else
        # Jeśli zapis się nie powiódł, zwróć błąd
        render json: @commitment.errors, status: :unprocessable_entity
      end
    end

  # PATCH/PUT /commitments/1
  def update
    # Pobierz identyfikator grupy z ciała żądania
    group_id = params[:group_id]
    if group_id.nil?
      render json: { error: "Missing group_id parameter" }, status: :bad_request
      return
    end
    # Pobierz identyfikator użytkownika wystawiającego zobowiązanie z ciała żądania
    user_id = params[:user_id]
    if user_id.nil?
      render json: { error: "Missing user_id parameter" }, status: :bad_request
      return
    end

    # Pobierz obiekt grupy o podanym identyfikatorze
    @groupinfo = Groupinfo.find_by(id: group_id)
    if @groupinfo.nil?
      render json: { error: "Group with given id not found" }, status: :not_found
      return
    end

    @user = User.find_by(id: user_id)
    if @user.nil?
      render json: { error: "User with given id not found" }, status: :not_found
      return
    end

    # Pobierz pozostałe parametry z ciała żądania

    commitmentamount = JSON.parse(request.body.read)['commitmentamount']
    commitmentdesc = JSON.parse(request.body.read)['commitmentdesc']
    occurancedate = JSON.parse(request.body.read)['occurancedate']
    expirationdate = JSON.parse(request.body.read)['expirationdate']

    if @commitment.update(commitmentdesc: commitmentdesc,
                          commitmentamount: commitmentamount,
                          occurancedate: occurancedate,
                          expirationdate: expirationdate,
                          groupinfo_id: @groupinfo.id,
                          user_id: @user.id)
      render json: @commitment
    else
      render json: @commitment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /commitments/1
  def destroy
    # Pobierz identyfikator grupy z ciała żądania
    group_id = JSON.parse(request.body.read)['group_id']
    if group_id.nil?
      render json: { error: "Missing group_id parameter" }, status: :bad_request
      return
    end
    if Groupinfo.exists?(id: group_id)
      @commitment.destroy
      render json: { message: 'Commitment deleted!' }, status: :ok
    else
      render json: @commitment.errors, status: :unprocessable_entity
    end

  end

  def split
    # Pobierz identyfikator zobowiązania z ciała żądania
    commitment_id = JSON.parse(request.body.read)['commitment_id']
    if commitment_id.nil?
      render json: { error: "Nie podano o jaki numer zobowiązania chodzi!" }, status: :bad_request
      return
    end

    # Pobierz obiekt zobowiązania o podanym identyfikatorze
    @commitment = Commitment.find_by(id: commitment_id)
    if @commitment.nil?
      render json: { error: "Zobowiązanie o numerze id #{commitment_id} nie zostało odnalezione!" }, status: :not_found
      return
    end

    if Bill.exists?(commitment_id: commitment_id)
      # Zabezpieczenie żeby nie rozdzielać dwa razy tego samego zobowiązania
      render json: { error: "Rachunek dla tego zobowiązania został już rozdzielony!" }, status: :unprocessable_entity
    else
      # Pobierz tablicę użytkowników należących do grupy zobowiązania
      group_users = @commitment.groupinfo.users

      # Pobierz tablicę z identyfikatorami użytkowników i kwotami rachunków z ciała żądania
    bills_params = params[:bills]


    # Iteruj przez tablicę bills_params i twórz nowe rachunki dla każdego użytkownika
    bills = []
    amount_sum = 0
    bills_params.each do |bills_paramsy|
      user_id = bills_paramsy[:user_id]
      amount = bills_paramsy[:amount]

      if !group_users.include?(User.find_by(id: user_id))
        # Jeśli użytkownik nie należy do grupy, zwróć błąd
        render json: { error: "Użytkownik o id #{user_id} nie należy do grupy zobowiązania!" }, status: :unprocessable_entity
        return
      end
      # Utwórz nowy rachunek dla użytkownika o podanym identyfikatorze i kwocie
      bill = Bill.new(user_id: user_id, amount: amount, commitment_id: commitment_id)
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
      render json: { error: "Suma wartości wszystkich rachunków musi być równa wartości zobowiązania!" }, status: :unprocessable_entity
    end
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
