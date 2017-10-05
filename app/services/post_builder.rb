class PostBuilder
  def initialize(post_params, author_params)
    @initial_post_params = post_params
    @author_params = author_params
  end

  def create
    author_created? && post_created?
  end

  def errors
    entities.each_with_object({}) do |entity, res|
      next if entity.errors.messages.blank?

      res[entity.model_name.element.to_sym] = entity.errors.messages
    end
  end

  private

  def entities
    [author, post]
  end

  def author_created?
    !author.new_record?
  end

  def post_created?
    !post.new_record?
  end

  def author
    @author_obj ||= User.find_or_create_by(login: author_params[:login])
  end

  def post
    @post_obj ||= Post.create(post_params)
  end

  def post_params
    @initial_post_params.tap do |p|
      p[:user_id] = author.id
    end
  end
end
