class Ip < ApplicationRecord
  has_many :posts_ips
  has_many :posts, through: :posts_ips
end
