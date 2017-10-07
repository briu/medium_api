class CreateUsersIps < ActiveRecord::Migration[5.0]
  def change
    create_table :users_ips do |t|
      t.integer :user_id
      t.integer :ip_id

      t.timestamps
    end

    add_index :users_ips, [:user_id, :ip_id], unique: true
  end
end
