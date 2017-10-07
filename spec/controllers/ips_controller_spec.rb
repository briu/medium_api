require 'spec_helper'

describe IpsController, :type => :api do
  describe '#index' do
    context 'with users' do
      before do
        @login1 = Faker::Name.name
        @login2 = Faker::Name.name
        @login3 = Faker::Name.name
        post_params1 = { title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph }
        author_params1 = { login: @login1 }
        @ip1 = '127.0.0.1'
        @ip2 = '127.0.0.2'

        post_params2 = { title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph }
        author_params2 = { login: @login2 }

        post_params3 = { title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph }
        author_params3 = { login: @login3 }

        PostBuilder.new({
          post_params: post_params1,
          author_params: author_params1,
          ip: @ip1
        }).create

        PostBuilder.new({
          post_params: post_params2,
          author_params: author_params2,
          ip: @ip1
        }).create

        PostBuilder.new({
          post_params: post_params3,
          author_params: author_params3,
          ip: @ip2
        }).create

        get '/ips'
      end

      it 'should include the same ip' do
        expect(json.keys).to include @ip1
      end

      it 'should not include the only one ip' do
        expect(json.keys).not_to include @ip2
      end
    end
  end
end
