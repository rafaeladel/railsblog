class User < ActiveRecord::Base
	enum role: { user: 0, admin: 1 }

	after_initialize :set_default_role, if: :new_record?

  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

	has_many :articles

	def set_default_role 
		self.role ||= :user
	end

	def role?(asked_role)
		self.class.roles[asked_role] <= self.class.roles[self.role]
	end

	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
			user.email = auth.info.email
			user.password = Devise.friendly_token[0,20]
		end
	end

	def self.new_with_session(params, session) 
		super.tap do |user|
			if data = session["devise.facebook.data"] && session["devise.facebook_data"]["extra"]["raw_info"]
				user.email = data["email"] if user.email.blank?
			end
		end
	end
end
