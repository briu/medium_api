class RatesController < ApplicationController
  def create
    rate = Rate.create(rate_params)
    if rate.save
      render json: { avg_rate: Rate.avg_post_rate(rate.post_id) }
    else
      render json: rate.errors, status: :unprocessable_entity
    end
  end

  private

  def rate_params
    params.require(:rate).permit(:post_id, :value)
  end
end
