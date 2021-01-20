class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[twitch]
         # :confirmable, :trackable, :lockable

  has_many :tags
  has_many :devices

  def self.from_omniauth(auth)
    user = find_or_create_by(provider: auth.provider, uid: auth.uid)

    user.email = auth.info.email
    user.name = auth.info.name
    user.description = auth.info.description
    user.image = auth.info.image
    user.password = Devise.friendly_token[0,20]
    user.save

    user
  end
end
