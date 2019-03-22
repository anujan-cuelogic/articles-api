class User < ApplicationRecord

  has_many :articles

  def number_of_articles
    articles.count
  end

  def number_of_followers
    id + 2
  end

  def number_of_following
    id + 3
  end

end
