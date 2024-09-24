class UserSerializer < ActiveModel::Serializer
  attributes :id , :email, :image_url, :screen_name
  # belongs_to :walle

end