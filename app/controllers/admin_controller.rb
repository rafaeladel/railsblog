class AdminController < ApplicationController
	before_action :authenticate_user!
	before_action :authorize_user

	def index

	end


	private
		def authorize_user
			raise "Access deined" if not current_user.role?(:admin)
		end
end