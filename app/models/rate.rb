class Rate < ApplicationRecord
  belongs_to :post

  validates :value, inclusion: { in: 0..5 }
end
