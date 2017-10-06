class IpsController < ApplicationController
  def index
    render json: PostsByIpPresenter.new(Post.group_by_same_ip)
  end
end
