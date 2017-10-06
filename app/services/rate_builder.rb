class RateBuilder
  MAX_RETRIES = 2

  attr_reader :post, :errors

  delegate :avg_rate, to: :post

  def initialize(rate_params)
    @rate_params = rate_params
    @post = Post.find(rate_params[:post_id])
    @retries  = 0
    @errors = []
  end

  def create
    begin
      Rate.transaction do
        rate = Rate.new(@rate_params)
        rate.save!

        current_avg_rate = Rate.avg_post_rate(@post.id)

        @post.avg_rate = current_avg_rate
        @post.save!

        true
      end
    rescue ActiveRecord::StaleObjectError
      return false if @retries == MAX_RETRIES

      @retries += 1
      create
    rescue ActiveRecord::RecordInvalid => e
      @errors << e.message
      false
    end
  end
end
