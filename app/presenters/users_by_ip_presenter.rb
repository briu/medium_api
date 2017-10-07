class UsersByIpPresenter
  def initialize(ips_users_relation)
    @relation = ips_users_relation
  end

  def as_json(*)
    @relation.group_by(&:ip).each_with_object({}) do |(ip, users_ips), res|
      res[ip.value] = users_ips.map(&:user).map(&:login)
    end
  end
end
