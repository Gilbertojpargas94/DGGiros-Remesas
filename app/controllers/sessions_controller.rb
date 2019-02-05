class SessionsController < Devise::SessionsController
  def new
  	@home_page = true
    super
  end
end