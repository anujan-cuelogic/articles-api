class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :username, :bio, :number_of_quotes, :number_of_followers, :number_of_following
  has_many :articles
end
