class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :username, :bio, :number_of_articles, :number_of_followers, :number_of_following, :profile_picture
  has_many :articles
  has_many :followings
  has_many :followers
end
