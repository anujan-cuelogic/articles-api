class User < ApplicationRecord

  devise :database_authenticatable, :registerable, :recoverable, :rememberable#, :validatable

  before_validation :write_uuid

  validates :uuid, presence: true

  has_many :articles
  has_many :followers, class_name: 'User'
  has_many :followings, foreign_key: :following_id, class_name: 'User'


  def number_of_articles
    articles.count
  end

  def number_of_followers
    id + 2
  end

  def number_of_following
    id + 3
  end

  private

  def write_uuid
    self.uuid = SecureRandom.uuid unless uuid?
  end

end
