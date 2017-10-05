class Post < ApplicationRecord
  validates :title, :body, presence: true

  def self.most_rated_posts(limit = 10)
    select(:title, :body).order('avg_rate DESC').limit(limit)
  end
end
