class Post < ApplicationRecord
  has_one :ip, through: :posts_ip
  has_one :posts_ip
  belongs_to :user

  validates :title, :body, presence: true

  class << self
    def most_rated_posts(limit = 10)
      select(:title, :body).order('avg_rate DESC').limit(limit)
    end

    def group_by_same_ip
      select(:ip, :user_id).includes(:user).group(:ip, :user_id).having('count(*) > 1')
    end
  end
end
