class ApplicationController < ActionController::Base
	before_action :set_current_user

	def set_current_user
	  Quotation.current_user = current_user
	end

	def after_sign_in_path_for(resource)
		if current_user.type_person != 'normal'
			quotations_path
		elsif not current_user.quotations.nil?
			quotations_path
		else
			new_quotation_path
		end
	end
end
