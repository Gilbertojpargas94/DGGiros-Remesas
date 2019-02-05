class PasswordsController < Devise::PasswordsController
  def new
  	@home_page = true
    super
  end

  def edit
  	@home_page = true
    super
  end
end