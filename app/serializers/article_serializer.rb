class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_date
  has_one :user
end
