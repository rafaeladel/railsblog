class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def facebook
		@user = User.from_omniauth(request.env["omniauth.auth"])
		puts request.env["omniauth.auth"].inspect
		if @user.persisted?
			process_and_redirect @user
		else
			if User.exists?(email: @user.email) 
				redirect_to new_user_session_url, notice: "Email already exists."
			else
				@user.skip_confirmation!
				@user.save!
				process_and_redirect @user
			end
		end
	end

	private
		def process_and_redirect(user)
			sign_in_and_redirect user, event: :authentication
			set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
		end
end