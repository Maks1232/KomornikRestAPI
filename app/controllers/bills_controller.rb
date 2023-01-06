class BillsController < ApplicationController
  before_action :authentication
  before_action :set_bill, only: %i[ show update destroy ]

  # GET /bills
  def index
    @bills = Bill.all

    render json: @bills
  end

  # GET /bills/1
  def show
    render json: @bill
  end

  # POST /bills
  def create
    @bill = Bill.new(bill_params)

    if @bill.save
      render json: @bill, status: :created, location: @bill
    else
      render json: @bill.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bills/1
  def update

    # Pobierz obiekt rachunku o podanym identyfikatorze
    @bill = Bill.find(params[:id])

    # Sprawdź, czy rachunek został znaleziony
    if @bill.nil?
      render json: { error: "Rachunek o podanym identyfikatorze nie został odnaleziony" }, status: :not_found
      return
    end

    # Aktualizuj obiekt rachunku na podstawie parametrów przesłanych w żądaniu
    if @bill.update(bill_params)
      # Jeśli aktualizacja się powiodła, zwróć odpowiedź z aktualizowanym obiektem rachunku
      render json: @bill, status: :ok
    else
      # Jeśli aktualizacja się nie powiodła, zwróć błąd
      render json: { error: "Nie udało się zaktualizować rachunku" }, status: :unprocessable_entity
    end
  end

  # DELETE /bills/1
  def destroy
    @bill.destroy
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bill
      @bill = Bill.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bill_params
      params.require(:bill).permit( :ispaid)
    end
end
