class User < ApplicationRecord

  has_one_attached :image
  include Devise::JWT::RevocationStrategies::JTIMatcher

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self




    has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id', dependent: :destroy
    has_many :received_messages, class_name: 'Message', foreign_key: 'recipient_id', dependent: :destroy

          def jwt_payload
            super
          end


          def image_url

            Rails.application.routes.url_helpers.url_for(image) if image.attached?


          end

end
