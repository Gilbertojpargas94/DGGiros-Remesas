class BanksController < ApplicationController
  before_action :set_bank, only: [:show, :edit, :update, :destroy]
  before_action :ony_worker, only: [:show, :edit, :destroy, :new, :index, :update, :create]
  before_action :only_admin, only: [:edit, :destroy, :new, :update, :create]
  # GET /banks
  # GET /banks.json
  def index
    @banks = Bank.all
  end

  # GET /banks/1
  # GET /banks/1.json
  def show
  end

  # GET /banks/new
  def new
    @bank = Bank.new
    @banks_ = ['Banesco','Banco de Venezuela', 'BBVA Provincial', 'Mercantil',
      'Banco Occidental de Descuento','Banco Bicentenario', 
      'Banco Nacional de Crédito', 'Banco del Tesoro', 'Bancaribe', 
      'Banco Exterior', 'Banco Fondo Común', 'Banco Venezolano de Crédito',
      'Banco Sofitasa', 'Banplus', 'Bancrecer', 'Banco Plaza', 'Banco Caroní',
      'Banco Activo', 'Banco de Comercio Exterior', 'DELSUR', 'Banfanb', '100% Banco',
      'Banco Agrícola de Venezuela', 'Bancamiga', 'Instituto Municipal de Crédito Popular',
      'Citibank Sucursal Venezuela', 'Mi Banco', 'Bangente', 
      'Banco de Exportación y Comercio', 'Banco Internacional de Desarrollo']
  end

  # GET /banks/1/edit
  def edit
    @banks_ = ['Banesco','Banco de Venezuela', 'BBVA Provincial', 'Mercantil',
      'Banco Occidental de Descuento','Banco Bicentenario', 
      'Banco Nacional de Crédito', 'Banco del Tesoro', 'Bancaribe', 
      'Banco Exterior', 'Banco Fondo Común', 'Banco Venezolano de Crédito',
      'Banco Sofitasa', 'Banplus', 'Bancrecer', 'Banco Plaza', 'Banco Caroní',
      'Banco Activo', 'Banco de Comercio Exterior', 'DELSUR', 'Banfanb', '100% Banco',
      'Banco Agrícola de Venezuela', 'Bancamiga', 'Instituto Municipal de Crédito Popular',
      'Citibank Sucursal Venezuela', 'Mi Banco', 'Bangente', 
      'Banco de Exportación y Comercio', 'Banco Internacional de Desarrollo']
  end

  # POST /banks
  # POST /banks.json
  def create
    @bank = Bank.new(bank_params)
    @banks_ = ['Banesco','Banco de Venezuela', 'BBVA Provincial', 'Mercantil',
      'Banco Occidental de Descuento','Banco Bicentenario', 
      'Banco Nacional de Crédito', 'Banco del Tesoro', 'Bancaribe', 
      'Banco Exterior', 'Banco Fondo Común', 'Banco Venezolano de Crédito',
      'Banco Sofitasa', 'Banplus', 'Bancrecer', 'Banco Plaza', 'Banco Caroní',
      'Banco Activo', 'Banco de Comercio Exterior', 'DELSUR', 'Banfanb', '100% Banco',
      'Banco Agrícola de Venezuela', 'Bancamiga', 'Instituto Municipal de Crédito Popular',
      'Citibank Sucursal Venezuela', 'Mi Banco', 'Bangente', 
      'Banco de Exportación y Comercio', 'Banco Internacional de Desarrollo']
    
    respond_to do |format|
      if @bank.save
        format.html { redirect_to @bank, notice: 'Banco fue creado con éxito.' }
        format.json { render :show, status: :created, location: @bank }
      else
        format.html { render :new }
        format.json { render json: @bank.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /banks/1
  # PATCH/PUT /banks/1.json
  def update
    @banks_ = ['Banesco','Banco de Venezuela', 'BBVA Provincial', 'Mercantil',
      'Banco Occidental de Descuento','Banco Bicentenario', 
      'Banco Nacional de Crédito', 'Banco del Tesoro', 'Bancaribe', 
      'Banco Exterior', 'Banco Fondo Común', 'Banco Venezolano de Crédito',
      'Banco Sofitasa', 'Banplus', 'Bancrecer', 'Banco Plaza', 'Banco Caroní',
      'Banco Activo', 'Banco de Comercio Exterior', 'DELSUR', 'Banfanb', '100% Banco',
      'Banco Agrícola de Venezuela', 'Bancamiga', 'Instituto Municipal de Crédito Popular',
      'Citibank Sucursal Venezuela', 'Mi Banco', 'Bangente', 
      'Banco de Exportación y Comercio', 'Banco Internacional de Desarrollo']
      
    respond_to do |format|
      if @bank.update(bank_params)
        format.html { redirect_to @bank, notice: 'Banco fue actualizado con éxito.' }
        format.json { render :show, status: :ok, location: @bank }
      else
        format.html { render :edit }
        format.json { render json: @bank.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /banks/1
  # DELETE /banks/1.json
  def destroy
    @bank.destroy
    respond_to do |format|
      format.html { redirect_to banks_url, notice: 'Banco fue eliminado con éxito.' }
      format.json { head :no_content }
    end
  end

  private
    def ony_worker
      if not current_user.nil?
        if current_user.type_person == 'normal'
          redirect_to root_path, notice: "No tienes permiso para acceder a esta sección, debes ser un trabajador", status: :unauthorized
        end
      else
        redirect_to new_user_session_path, notice: "Debes iniciar sesion para acceder", status: :unauthorized
      end
    end

    def only_admin
      if not current_user.nil?
        if current_user.type_person == 'worker'
          redirect_to banks_path, notice: "No tienes permiso para acceder a esta sección, debes ser administrador", status: :unauthorized
        end
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_bank
      @bank = Bank.find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def bank_params
      params.require(:bank).permit(:name, :headline, :status)
    end
end
