class Message < ApplicationRecord

  # belongs_to :user
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  belongs_to :parent_message, class_name: 'Message', optional: true
  has_many :replies, class_name: "Message", foreign_key: "parent_message_id"
  # belongs_to :user
end
