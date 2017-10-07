class PostBuilder
  attr_reader :post_obj, :errors

  def initialize(post_params:, author_params:, ip:)
    @post_params = post_params.with_indifferent_access
    @author_params = author_params.with_indifferent_access
    @ip = ip
    @errors = []
  end

  def create
    begin
      ApplicationRecord.transaction do
        author_obj = User.find_or_create_by!(login: @author_params[:login])
        @post_obj  = author_obj.posts.create!(@post_params)
        ip_obj = Ip.find_or_create_by!(value: @ip)
        PostsIp.create!(post_id: @post_obj.id, ip_id: ip_obj.id)
        UsersIp.find_or_create_by!(ip_id: ip_obj.id, user_id: author_obj.id)
        true
      end
    rescue ActiveRecord::RecordInvalid => e
      @errors << e.message
      false
    end
  end
end
