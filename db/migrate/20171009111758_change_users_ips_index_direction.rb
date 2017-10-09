class ChangeUsersIpsIndexDirection < ActiveRecord::Migration[5.0]
  def change
    remove_index :users_ips, [:user_id, :ip_id]
    add_index :users_ips, [:ip_id, :user_id], unique: true
  end
end
