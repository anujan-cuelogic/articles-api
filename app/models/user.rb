class User < ApplicationRecord

  has_many :articles
  has_many :quotes

  def number_of_quotes
    id + 1
  end

  def number_of_followers
    id + 2
  end

  def number_of_following
    id + 3
  end

end
