class AddIndexToPostsAvgRate < ActiveRecord::Migration[5.0]
  def change
    add_index :posts, :avg_rate
  end
end
