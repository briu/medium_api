class PostsController < ApplicationController
  def index
    # TODO: move to post namespace for different conditions
    limit = params[:limit] || 10
    render json: Post.most_rated_posts(limit), adapter: :json
  end

  def create
    builder_params = {
      post_params: post_params.to_h,
      author_params: author_params.to_h,
      ip: request.remote_ip
    }
    builder = PostBuilder.new(builder_params)

    if builder.create
      render json: builder.post_obj, adapter: :json
    else
      render json: builder.errors, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def author_params
    params.require(:author).permit(:login)
  end
end
