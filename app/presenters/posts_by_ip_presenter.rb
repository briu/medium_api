class PostsByIpPresenter
  def initialize(posts_relation)
    @posts_relation = posts_relation
  end

  def as_json(*)
    @posts_relation.group_by(&:ip).each_with_object({}) do |(ip, posts), res|
      res[ip] = posts.map(&:user).map(&:login)
    end
  end
end
