class User < ApplicationRecord

  devise :database_authenticatable, :registerable, :recoverable, :rememberable#, :validatable

  before_validation :write_attrs

  validates :uuid, presence: true

  validates :username, presence: true, uniqueness: true

  has_many :articles
  has_many :followers, class_name: 'User'
  has_many :followings, foreign_key: :following_id, class_name: 'User'
  has_one_attached :avatar

  def avatar_url
    if avatar.attached?
      # active_storage_disk_service = ActiveStorage::Service::DiskService.new(root: Rails.root.to_s + '/storage/')
      # active_storage_disk_service.send(:path_for, avatar.blob.key)
      ActiveStorage::Blob.service.send(:path_for, avatar.key).gsub('/home/anuja/Documents/EmberWorkspace/quotes/public', '')
    else
      '/images/gravatar.png'
    end
  end

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

  def write_attrs
    self.uuid = SecureRandom.uuid unless uuid?
    self.profile_picture = '/images/gravatar.png' unless profile_picture?
  end

end
