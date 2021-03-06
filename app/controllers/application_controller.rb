class ApplicationController < ActionController::Base
	include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private 

  	def after_sign_in_path_for(resource)
		user_url resource
  	end
end
