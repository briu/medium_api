class UsersIp < ApplicationRecord
  belongs_to :user
  belongs_to :ip

  def self.users_with_same_ip
    # SUBSELECT FOR ONE QUERY?
    where(ip_id: select(:ip_id).group(:ip_id).having('count(*) > 1').pluck(:ip_id)).includes(:user, :ip)
  end
end
