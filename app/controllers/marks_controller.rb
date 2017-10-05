class MarksController < ApplicationController
  def create
    mark = Mark.create(mark_params)
    if mark.save
      render json: { avg_rate: Mark.avg_post_rate(mark.post_id) }
    else
      render json: mark.errors, status: :unprocessable_entity
    end
  end

  private

  def mark_params
    params.require(:mark).permit(:post_id, :value)
  end
end
