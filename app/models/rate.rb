class Rate < ApplicationRecord
    validates :country, :value,  presence: true
    validates :value, numericality: true, numericality: {greater_than: 0 }

    validate :country_exist

    def country_exist
    	if not self.country.nil?
            rate = Rate.where('lower(country) = ?', self.country.downcase).first
    		if not rate.nil?
                if (not self.id.nil?) && rate.id != self.id
                    errors.add(:rate, "El pais modificado ya se encuentra registrado") 
                end
                if self.id.nil?
                    errors.add(:rate, "El pais seleccionado ya se encuentra registrado") 
                end    
    			
    		end	
    	end
    end


end
