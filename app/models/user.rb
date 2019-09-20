class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :omniauthable,
:omniauth_providers => [:facebook]
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.created_at = Time.new
      user.encrypted_password = Devise.friendly_token[0, 20]
      user.name = auth.info.name   # assuming the user model has a name
      puts user.name
      # user.avatar = auth.info.image # assuming the user model has an images
      user.skip_confirmation!
    end
  end
  has_many :campaigns, :dependent => :destroy
  has_many :comments, :dependent => :destroy
end
