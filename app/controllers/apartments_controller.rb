class ApartmentsController < ApplicationController
  before_action :set_apartment, only: [:show, :edit, :update, :destroy, :fees]
  before_action :require_login

  # GET /apartments
  # GET /apartments.json
  def index
    if can? :edit, Apartment
      @apartments = Apartment.all
    else
      @apartments = current_user.apartments
    end
  end

  # GET /apartments/1
  # GET /apartments/1.json
  def show
  end

  # GET /apartments/new
  def new
    unless can? :edit, Apartment
      redirect_to root_path, alert: 'Acesso negado. Permissão insuficiente.'
    end
    @apartment = Apartment.new
  end

  # GET /apartments/1/edit
  def edit
    unless can? :edit, Apartment
      redirect_to root_path, alert: 'Acesso negado. Permissão insuficiente.'
    end
  end

  # POST /apartments
  # POST /apartments.json
  def create
    @apartment = Apartment.new(apartment_params)

    respond_to do |format|
      if @apartment.save
        format.html {redirect_to @apartment, notice: 'Apartment was successfully created.'}
        format.json {render :show, status: :created, location: @apartment}
      else
        format.html {render :new}
        format.json {render json: @apartment.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /apartments/1
  # PATCH/PUT /apartments/1.json
  def update
    respond_to do |format|
      if @apartment.update(apartment_params)
        format.html {redirect_to @apartment, notice: 'Apartment was successfully updated.'}
        format.json {render :show, status: :ok, location: @apartment}
      else
        format.html {render :edit}
        format.json {render json: @apartment.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /apartments/1
  # DELETE /apartments/1.json
  def destroy
    unless can? :edit, Apartment
      redirect_to root_path, alert: 'Acesso negado. Permissão insuficiente.'
    end
    @apartment.destroy
    respond_to do |format|
      format.html {redirect_to apartments_url, notice: 'Apartment was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  def fees
    @condominium_fees = @apartment.condominium_fees
    @expenses = Expense.this_month(Date.today)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_apartment
    @apartment = Apartment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def apartment_params
    params.require(:apartment).permit(:number, :number_of_rooms, :resident_id, :owner_id)
  end
end
