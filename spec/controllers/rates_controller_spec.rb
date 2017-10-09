require 'spec_helper'

describe PostsController, :type => :api do
  describe '#create' do
    let(:author) { User.create({ login: Faker::Name.name }) }
    let(:post_obj) do
      Post.create({ title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph, user: author })
    end

    let(:default_rates) do
      [1, 3, 5].map { |r| Rate.create(post: post_obj, value: r) }
    end

    context 'with valid params' do
      before do
        rate_value = 2
        result_rates_arr = [*default_rates.map(&:value), rate_value]
        @result_avg = result_rates_arr.sum / result_rates_arr.size.to_f
        @rates_count = Rate.count
        post '/rates', rate: { post_id: post_obj.id, value: rate_value }
      end

      it 'responds with a 200 status' do
        expect(last_response.status).to eq 200
      end

      it 'should create new rate' do
        expect(Rate.count).to eq(@rates_count + 1)
      end

      it 'should respond with avg rate' do
        expect(json[:avg_rate]).to eq @result_avg
      end
    end

    context 'with invalid params' do
       before do
        @rates_count = Rate.count
        post '/rates', rate: { post_id: post_obj.id, value: 6 }
      end

      it 'responds with a 422 status' do
        expect(last_response.status).to eq 422
      end

      it 'should not create new rate' do
        expect(Rate.count).to eq(@rates_count)
      end
    end
  end
end
