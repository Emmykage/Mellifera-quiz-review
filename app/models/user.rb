class User < ApplicationRecord

  has_one_attached :image
  include Devise::JWT::RevocationStrategies::JTIMatcher

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self


    has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id', dependent: :destroy
    has_many :received_messages, class_name: 'Message', foreign_key: 'recipient_id', dependent: :destroy


    def self.from_omniauth(auth)

      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
        user.name = auth.info.name
        user.image = auth.info.image
      end
    end

    def generate_jwt
      JWT.encode({ id: id, exp: 60.days.from_now.to_i }, Rails.application.secrets.secret_key_base)
    end
          def jwt_payload
            super
          end


          def image_url

            Rails.application.routes.url_helpers.url_for(image) if image.attached?


          end

          def generate_refresh_token
            self.refresh_token = SecureRandom.hex(10)
            if save
              self.refresh_token
            else
              errors.full_messages
            end
          end

end
