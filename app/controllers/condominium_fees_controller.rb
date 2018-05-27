class CondominiumFeesController < ApplicationController
  before_action :set_condominium_fee, only: [:show, :edit, :update, :destroy]

  # GET /condominium_fees
  # GET /condominium_fees.json
  def index
    @condominium_fees = CondominiumFee.all
  end

  # GET /condominium_fees/1
  # GET /condominium_fees/1.json
  def show
  end

  # GET /condominium_fees/new
  def new
    @condominium_fee = CondominiumFee.new
  end

  # GET /condominium_fees/1/edit
  def edit
  end

  # POST /condominium_fees
  # POST /condominium_fees.json
  def create
    @condominium_fee = CondominiumFee.new(condominium_fee_params)

    respond_to do |format|
      if @condominium_fee.save
        format.html { redirect_to @condominium_fee, notice: 'Condominium fee was successfully created.' }
        format.json { render :show, status: :created, location: @condominium_fee }
      else
        format.html { render :new }
        format.json { render json: @condominium_fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /condominium_fees/1
  # PATCH/PUT /condominium_fees/1.json
  def update
    respond_to do |format|
      if @condominium_fee.update(condominium_fee_params)
        format.html { redirect_to @condominium_fee, notice: 'Condominium fee was successfully updated.' }
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
    date = params[:date]
    ap_id = params[:apartment]
    if ap_id
      success = CondominiumFee.generate_condominium_fee(Apartment.where(id: ap_id), Date.today)
    else
      success = CondominiumFee.generate_condominium_fee(Apartment.all, Date.today)
    end
    if success
      redirect_to condominium_fees_path, notice: 'Taxas atualizadas.'
    else
      redirect_to condominium_fees_path, error: 'Um erro ocorreu.'
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
