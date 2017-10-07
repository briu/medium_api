class UsersIp < ApplicationRecord
  belongs_to :user
  belongs_to :ip

  def self.users_with_same_ip
    # SUBSELECT FOR ONE QUERY?
    ip_ids = select(:ip_id).group(:ip_id).having('count(*) > 1').pluck(:ip_id)
    select(:user_id, :ip_id).where(ip_id: ip_ids).includes(:user, :ip)
  end
end
