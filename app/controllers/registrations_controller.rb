class RegistrationsController < Devise::RegistrationsController
	#before_action :authenticate_user!, :redirect_unless_admin,  only: [:new, :create]
  	#skip_before_action :require_no_authentication

	def new
		@home_page = true
        # super is for devise controller work as default
		# super para que el controlador siga haciendo lo que haria el controlador padre
		super
	end

	#def signout
	#	if something_is_not_kosher
	#		redirect_to signout_path and return
	#	end
	#end

	def create
		@home_page = true
		super
	end

	def update
		super
	end

	protected
	def after_sign_up_path_for(resource)
		# after a new user is register, is redirect_to a new company path
		if not current_user.nil?
			if current_user.type_person != 'normal'
				workers_path
			else
				new_quotation_path
			end
		end
		
	end


	private

    def sign_up_params
        # For assign custom parameters like name
		allow = [:email, :name, :password, :password_confirmation, :phone, :status, :type_person, :address, :dni]
		params.require(resource_name).permit(allow)
	end
end
