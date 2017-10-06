class Rate < ApplicationRecord
  belongs_to :post

  validates :value, inclusion: { in: 0..5 }

  def self.avg_post_rate(post_id)
    select('avg(value) as av', :post_id).where(post_id: post_id).group(:post_id)
                                        .map(&:av).first.to_f
  end
end
