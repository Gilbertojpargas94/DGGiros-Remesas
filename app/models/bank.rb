class Bank < ApplicationRecord
    validates :name,:headline, presence: true
    validates :status, inclusion: { in: [true,false]}
    
    validate :bank_exist

    def bank_exist
	    if not self.name.nil?
	      banks = ['Banesco','Banco de Venezuela', 'BBVA Provincial', 'Mercantil',
	      'Banco Occidental de Descuento','Banco Bicentenario', 
	      'Banco Nacional de Crédito', 'Banco del Tesoro', 'Bancaribe', 
	      'Banco Exterior', 'Banco Fondo Común', 'Banco Venezolano de Crédito',
	      'Banco Sofitasa', 'Banplus', 'Bancrecer', 'Banco Plaza', 'Banco Caroní',
	      'Banco Activo', 'Banco de Comercio Exterior', 'DELSUR', 'Banfanb', '100% Banco',
	      'Banco Agrícola de Venezuela', 'Bancamiga', 'Instituto Municipal de Crédito Popular',
	      'Citibank Sucursal Venezuela', 'Mi Banco', 'Bangente', 
	      'Banco de Exportación y Comercio', 'Banco Internacional de Desarrollo']

	      if not banks.include?(self.name)
	        errors.add(:bank, "El banco seleccionado no esta registrado en nuestras plataformas")
	      end   
	    end
  	end

end
