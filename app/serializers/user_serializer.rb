class UserSerializer < ActiveModel::Serializer
  attributes :id , :email, :image_url
  # belongs_to :walle

end