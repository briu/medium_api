class PostBuilder
  attr_reader :post

  def initialize(post_params:, author_params:, ip:)
    @initial_post_params = post_params.with_indifferent_access
    @author_params = author_params.with_indifferent_access
  end

  def create
    # SHOULD AUTHOR BE CREATED IF POST FAILED?
    # IF SHOULD - WRAP TO TRANSACTION
    author_created? && post_created?
  end

  def errors
    entities.each_with_object({}) do |entity, res|
      next if entity.errors.messages.blank?

      res[entity.model_name.element.to_sym] = entity.errors.messages
    end
  end

  def post
    @post_obj ||= Post.create(post_params)
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
    @author_obj ||= User.find_or_create_by(login: @author_params[:login])
  end

  def post_params
    @initial_post_params.tap do |p|
      p[:user_id] = author.id
    end
  end
end
