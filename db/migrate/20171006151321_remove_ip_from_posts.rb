class RemoveIpFromPosts < ActiveRecord::Migration[5.0]
  def change
    remove_column :posts, :ip
  end
end
