class IpsController < ApplicationController
  def index
    render json: UsersByIpPresenter.new(UsersIp.users_with_same_ip)
  end
end
