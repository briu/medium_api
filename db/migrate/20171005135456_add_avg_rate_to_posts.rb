class AddAvgRateToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :avg_rate, :float
  end
end
