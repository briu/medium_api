class CreatePostsIps < ActiveRecord::Migration[5.0]
  def change
    create_table :posts_ips do |t|
      t.integer :post_id
      t.integer :ip_id
      t.integer :user_id

      t.timestamps
    end

    add_index :posts_ips, [:post_id, :ip_id]
    add_index :posts_ips, [:user_id, :ip_id]
  end
end
