class QuotationsController < ApplicationController
  before_action :set_quotation, only: [:show, :edit, :update, :destroy, :get_payment]
  before_action :is_singin, only: [:show, :edit, :new, :destroy, :index, :get_payment]
  before_action :any_quotation, only: [:index]
  before_action :your_quatation, only: [:show, :destroy, :edit, :get_payment]
  before_action :only_admin, only: [:destroy]
  # GET /quotations
  # GET /quotations.json
  def index
    @home_page = true
    if current_user.type_person != 'normal'
      @quotations = Quotation.all.order(status: :asc,created_at: :desc).paginate(page: params[:page], per_page: 10)
      respond_to do |format|
        format.html
        format.js
        format.pdf do
          @quotations = Quotation.all.order(status: :asc,created_at: :desc)
          render template: 'quotations/reports', pdf: "Reports"  
        end
      end
    else
      @quotations = current_user.quotations.order(status: :asc,created_at: :asc).paginate(page: params[:page], per_page: 8)
      respond_to do |format|
        format.html
        format.js
        format.pdf do
          redirect_to quotations_path, notice: "Solo puedes ver las cotizaciones que te pertenecen", status: :unauthorized 
        end
      end
    end
  end

  # GET /quotations/1
  # GET /quotations/1.json
  def show
    @home_page = true
  end

  # GET /quotations/new
  def new
    @home_page = true
    @banks = ['Banesco','Banco de Venezuela', 'BBVA Provincial', 'Mercantil',
      'Banco Occidental de Descuento','Banco Bicentenario', 
      'Banco Nacional de Crédito', 'Banco del Tesoro', 'Bancaribe', 
      'Banco Exterior', 'Banco Fondo Común', 'Banco Venezolano de Crédito',
      'Banco Sofitasa', 'Banplus', 'Bancrecer', 'Banco Plaza', 'Banco Caroní',
      'Banco Activo', 'Banco de Comercio Exterior', 'DELSUR', 'Banfanb', '100% Banco',
      'Banco Agrícola de Venezuela', 'Bancamiga', 'Instituto Municipal de Crédito Popular',
      'Citibank Sucursal Venezuela', 'Mi Banco', 'Bangente', 
      'Banco de Exportación y Comercio', 'Banco Internacional de Desarrollo']
    @quotation = Quotation.new
  end

  # GET /quotations/1/edit
  def edit
    @home_page = true
  end

  #this is for return a js with the rate for a country
  def get_rates
    @rate = Rate.where("country = ?", params[:country]).first
    respond_to do |format|
      format.js
    end
  end

  def get_banks
    @bank = Bank.where(:name => params[:name], :status => "Activo").first
    respond_to do |format|
      format.js
    end
  end

  def get_payment
    send_file(
      "#{@quotation.payment.path}",
      filename: "#{@quotation.payment_file_name}",
      type: "application/pdf", :x_sendifile => true
    )
  end
  # POST /quotations
  # POST /quotations.json
  def create
    @home_page = true
    @banks = ['Banesco','Banco de Venezuela', 'BBVA Provincial', 'Mercantil',
      'Banco Occidental de Descuento','Banco Bicentenario', 
      'Banco Nacional de Crédito', 'Banco del Tesoro', 'Bancaribe', 
      'Banco Exterior', 'Banco Fondo Común', 'Banco Venezolano de Crédito',
      'Banco Sofitasa', 'Banplus', 'Bancrecer', 'Banco Plaza', 'Banco Caroní',
      'Banco Activo', 'Banco de Comercio Exterior', 'DELSUR', 'Banfanb', '100% Banco',
      'Banco Agrícola de Venezuela', 'Bancamiga', 'Instituto Municipal de Crédito Popular',
      'Citibank Sucursal Venezuela', 'Mi Banco', 'Bangente', 
      'Banco de Exportación y Comercio', 'Banco Internacional de Desarrollo']
    @quotation = current_user.quotations.new(quotation_params)
    @quotation.code_create
    respond_to do |format|
      if @quotation.save
        if current_user.type_person == 'normal'
          format.html { redirect_to edit_quotation_path(@quotation), notice: 'La cotización fue creada exitosamente.' }
        else
          if not @quotation.payment_file_name.nil? 
            QuotationMailer.new_quotation(@quotation).deliver_later
            User.where.not(type_person: 'normal').each do |worker|
              QuotationMailer.new_quotation_worker(@quotation, worker).deliver_later
            end
          end
          format.html { redirect_to quotations_path, notice: 'La cotización fue creada exitosamente.' }
        end
        format.json { render :show, status: :created, location: @quotation }
      else
        format.html { render :new }
        format.json { render json: @quotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quotations/1
  # PATCH/PUT /quotations/1.json
  def update
    @home_page = true
    respond_to do |format|
      if @quotation.update(quotation_params)
        if (not @quotation.payment_file_name.nil?) && @quotation.status == 'Esperando Verificación'
          QuotationMailer.new_quotation(@quotation).deliver_later
          User.where.not(type_person: 'normal').each do |worker|
            QuotationMailer.new_quotation_worker(@quotation, worker).deliver_later
          end
        end
        if @quotation.status == 'Pagado'
          QuotationMailer.end_quotation(@quotation).deliver_later
          User.where.not(type_person: 'normal').each do |worker|
            QuotationMailer.end_quotation_worker(@quotation, worker).deliver_later
          end
        end
        format.html { redirect_to quotations_path, notice: 'La cotización fue actualizada con éxito.' }
        format.json { render :show, status: :ok, location: @quotation }
      else
        format.html { render :edit }
        format.json { render json: @quotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotations/1
  # DELETE /quotations/1.json
  def destroy
    @quotation.destroy
    respond_to do |format|
      format.html { redirect_to quotations_url, notice: 'La cotización fue eliminada con éxito.' }
      format.json { head :no_content }
    end
  end

  private
    def is_singin 
      if current_user.nil?
        redirect_to new_user_session_path, notice: "Debes iniciar sesion para acceder", status: :unauthorized
      end
    end
    
    def any_quotation
      if current_user.type_person == 'normal'
        if not current_user.quotations.count > 0
            redirect_to new_quotation_path, notice: "Realiza tu primera cotización" 
        end
      end
    end

    def your_quatation
      if current_user.type_person == 'normal'
        user_quotation = current_user.quotations.find_by(id: params[:id])
        if user_quotation.nil?
          redirect_to quotations_path, notice: "Solo puedes ver las cotizaciones que te pertenecen", status: :unauthorized
        end  
      end
    end

    def only_admin
      if current_user.type_person == 'worker'
        redirect_to quotations_path, notice: "No tienes permiso para acceder a esta sección, debes ser administrador", status: :unauthorized
      end
    end
    


    # Use callbacks to share common setup or constraints between actions.
    def set_quotation
      @quotation = Quotation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quotation_params
      params.require(:quotation).permit(:user_id, :order, :amount, :rate, :account, :country, :bank, :status, :gmail_account, :id_account, :headline_account, :payment, :name_user, :gmail_user, :address_user, :dni_user, :phone_user)
    end
end
