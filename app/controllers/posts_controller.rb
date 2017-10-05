class PostsController < ApplicationController
  def index
    # TODO: move to post namespace for different conditions
    limit = params[:limit] || 10
    render json: Post.most_rated_posts(limit)
  end

  def create
    builder = PostBuilder.new(post_params, author_params)

    if builder.create
      render json: builder.post
    else
      render json: builder.errors, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def author_params
    params.require(:author).permit(:login).tap do |p|
      p[:ip] = request.remote_ip
    end
  end
end
