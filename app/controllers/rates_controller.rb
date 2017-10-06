class RatesController < ApplicationController
  def create
    rate_builder = RateBuilder.new(rate_params)
    if rate_builder.create
      render json: { avg_rate: rate_builder.avg_rate }
    else
      render json: rate_builder.errors, status: :unprocessable_entity
    end
  end

  private

  def rate_params
    params.require(:rate).permit(:post_id, :value)
  end
end
