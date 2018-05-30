class CondominiumFeesController < ApplicationController
  before_action :set_condominium_fee, only: [:show, :edit, :update, :destroy, :payment_page]
  before_action :require_login

  # GET /condominium_fees
  # GET /condominium_fees.json
  def index
    unless can? :edit, CondominiumFee
      redirect_to root_path, alert: 'Acesso negado. Permissão insuficiente.'
    end
    @condominium_fees = CondominiumFee.all
  end

  # GET /condominium_fees/1
  # GET /condominium_fees/1.json
  def show
    unless can? :edit, CondominiumFee
      redirect_to root_path, alert: 'Acesso negado. Permissão insuficiente.'
    end
  end

  # GET /condominium_fees/new
  def new
    unless can? :edit, CondominiumFee
      redirect_to root_path, alert: 'Acesso negado. Permissão insuficiente.'
    end
    @condominium_fee = CondominiumFee.new
  end

  # GET /condominium_fees/1/edit
  def edit
  end

  # POST /condominium_fees
  # POST /condominium_fees.json
  def create
  end

  # PATCH/PUT /condominium_fees/1
  # PATCH/PUT /condominium_fees/1.json
  def update
    respond_to do |format|
      if @condominium_fee.update(condominium_fee_params)
        format.html { redirect_to root_url, notice: 'Condominium fee was successfully updated.' }
        format.json { render :show, status: :ok, location: @condominium_fee }
      else
        format.html { render :edit }
        format.json { render json: @condominium_fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /condominium_fees/1
  # DELETE /condominium_fees/1.json
  def destroy
    @condominium_fee.destroy
    respond_to do |format|
      format.html { redirect_to condominium_fees_url, notice: 'Condominium fee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def generate_fees
    unless can? :edit, CondominiumFee
      redirect_to root_path, alert: 'Acesso negado. Permissão insuficiente.'
    end
    due_date = params[:condominium_fee][:due_date].to_date
    puts '-----------------------------'
    puts due_date
    success = CondominiumFee.generate_condominium_fee(Apartment.all, due_date)
    if success
      redirect_to condominium_fees_path, notice: 'Taxas atualizadas.'
    else
      redirect_to condominium_fees_path, error: 'Um erro ocorreu.'
    end
  end

  def payment_page
  end

  def pay
    @condominium_fee = CondominiumFee.find(params[:id])
    if params[:postponed]
      @condominium_fee.postponed = true
      @expense = Expense.new
      @expense.apartment = @condominium_fee.apartment
      @expense.description = 'Multa 5% - Pagamento adiado para mês seguinte'
      @expense.value = (@condominium_fee.value * 5)/100
      @expense.month_of_ref = @condominium_fee.created_at + 1.month
      respond_to do |format|
        if @expense.save and @condominium_fee.save
          format.html { redirect_to root_url, notice: 'O pagamento da taxa de condomínio selecionada foi adiado com sucesso.' }
          format.json { render :show, status: :ok, location: @expense }
        else
          format.html { render :edit }
          format.json { render json: @condominium_fee.errors, status: :unprocessable_entity }
        end
      end
    else
      if Date.today > @condominium_fee.due_date
        @condominium_fee.value += (@condominium_fee.value*2)/100
      end
      @condominium_fee.paid = true
      respond_to do |format|
        if @condominium_fee.save
          format.html { redirect_to root_url, notice: 'A taxa de condomínio selecionada foi marcada como quitada.' }
          format.json { render :show, status: :ok, location: @condominium_fee }
        else
          format.html { render :edit }
          format.json { render json: @condominium_fee.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_condominium_fee
      @condominium_fee = CondominiumFee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def condominium_fee_params
      params.require(:condominium_fee).permit(:apartment_id, :value, :due_date, :paid)
    end
end
