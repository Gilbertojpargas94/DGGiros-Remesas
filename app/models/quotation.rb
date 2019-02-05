class Quotation < ApplicationRecord
  belongs_to :user
  cattr_accessor :current_user
  # has_attached_file is a method of the paperclip to work with images.
  # In the hash styles we pass diferents size for the image
  # you can add any name for this fields.
  # default_url is used when the field logo not has a image.
  has_attached_file :payment, styles: {thumb: "200x200", medium: "600x600", large: "1200x1200"}
  # This is for security reasons, only images can upload.
  validates_attachment_content_type :payment, content_type: ['image/jpeg', 'image/png', 'image/gif', 'application/pdf']
  
  validates :user_id, :order, :amount, :rate, :account, :country, :bank, :headline_account, presence: true
  validates :amount, :rate, numericality: true, on: :create
  validates :amount, numericality: {greater_than: 0 }, on: :create
  validates :phone_user, phone: { possible: true, allow_blank: true }

  validate :set_up_rate, :bank_exist, on: :create
  validate :status_exist, :dont_change, on: :update
  validate :update_status, on: [:update, :create]
   
  def code_create
    self.order = 'DG' + (Date.today).to_s + '0' + ((Quotation.last.nil? ? 0 : Quotation.last.id) + 1).to_s
  end

  def update_status
    if (not self.payment_file_name.nil?) && self.status == 'Esperando Comprobante'
      self.status = 'Esperando Verificación'
    end
  end

  def set_up_rate
    if not self.country.nil?
      rate_by_country = Rate.where("country = ?", self.country).first
      if not rate_by_country.nil?
        self.rate = rate_by_country.value
      else
        errors.add(:quotation, "El pais seleccionado no se encuentra registrado en nuestras plataformas")
      end
      
    end
  end

  def bank_exist
    if not self.bank.nil?
      banks = ['Banesco','Banco de Venezuela', 'BBVA Provincial', 'Mercantil',
      'Banco Occidental de Descuento','Banco Bicentenario', 
      'Banco Nacional de Crédito', 'Banco del Tesoro', 'Bancaribe', 
      'Banco Exterior', 'Banco Fondo Común', 'Banco Venezolano de Crédito',
      'Banco Sofitasa', 'Banplus', 'Bancrecer', 'Banco Plaza', 'Banco Caroní',
      'Banco Activo', 'Banco de Comercio Exterior', 'DELSUR', 'Banfanb', '100% Banco',
      'Banco Agrícola de Venezuela', 'Bancamiga', 'Instituto Municipal de Crédito Popular',
      'Citibank Sucursal Venezuela', 'Mi Banco', 'Bangente', 
      'Banco de Exportación y Comercio', 'Banco Internacional de Desarrollo']

      if not banks.include?(self.bank)
        errors.add(:quotation, "El banco seleccionado no esta registrado en nuestras plataformas")
      end   
    end
  end


  def dont_change
    if Quotation.current_user.type_person == 'worker'
      if self.status_was == 'Pagado' && self.status == 'Esperando Comprobante'
        errors.add(:quotation, "Solo el administrador puede regresar el estatus de la cotización")
      elsif self.status_was == 'Pagado' && self.status == 'Esperando Verificación'
        errors.add(:quotation, "Solo el administrador puede regresar el estatus de la cotización")
      end
    end
  end


  def status_exist
    if not self.status.nil?
      status = ['Esperando Comprobante','Esperando Verificación','Pagado']
      if status.include?(self.status)
        if self.status != 'Esperando Comprobante' && self.payment_file_name.nil? 
          errors.add(:quotation, "No se puede editar el estatus de la cotización porque el cliente aun no ha subido al sistema el recibo de pago")
        end
      else
        errors.add(:quotation, "El estatus seleccionado no esta registrado en nuestras plataformas")
      end
    end
  end
end
