class Article < ApplicationRecord
  belongs_to :user

  def created_date
    # created_at.strftime('%B %d, %Y %H:%M:%S')
    created_at.iso8601
  end

end
