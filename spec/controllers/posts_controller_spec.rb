require 'spec_helper'

describe PostsController, :type => :api do
  describe '#create' do
    context 'with valid params' do
      before do
        @users_count = User.count
        @posts_count = Post.count
        @params = { post: { title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph },
                    author: { login: Faker::Name.name } }.with_indifferent_access
        post '/posts', @params
      end

      it 'responds with a 200 status' do
        expect(last_response.status).to eq 200
      end

      it 'should create new user' do
        expect(User.count).to eq(@users_count + 1)
      end

      it 'should create new post' do
        expect(Post.count).to eq(@posts_count + 1)
      end

      it 'should respond with post data' do
        expect(json[:post]).to eq @params[:post]
      end
    end

    context 'with not valid post parameter' do
      before do
        @users_count = User.count
        @posts_count = Post.count
        @params = { post: { title: '', body: Faker::Lorem.paragraph },
                    author: { login: Faker::Name.name } }.with_indifferent_access
        post '/posts', @params
      end

      it 'responds with a 422 status' do
        expect(last_response.status).to eq 422
      end

      it 'should create new post' do
        expect(Post.count).to eq(0)
      end

      it 'should respond with error' do
        expect(json[:post]).to eq({ 'title' => ["can't be blank"] })
      end
    end

    context 'with not valid author parameter' do
      before do
        @users_count = User.count
        @posts_count = Post.count
        @params = { post: { title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph },
                    author: { login: '' } }.with_indifferent_access
        post '/posts', @params
      end

      it 'responds with a 422 status' do
        expect(last_response.status).to eq 422
      end

      it 'should create new user' do
        expect(User.count).to eq(0)
      end

      it 'should respond with error' do
        expect(json[:user]).to eq({ 'login' => ["can't be blank"] })
      end
    end
  end

  describe '#index' do
    let(:author) { User.create({ login: Faker::Name.name }) }

    context 'most rated posts' do
      before do
        @post_1 = Post.create(user: author, title: Faker::Lorem.sentence,
                              body: Faker::Lorem.paragraph, avg_rate: 1.2)
        @post_2 = Post.create(user: author, title: Faker::Lorem.sentence,
                              body: Faker::Lorem.paragraph, avg_rate: 2.2)
        @post_3 = Post.create(user: author, title: Faker::Lorem.sentence,
                              body: Faker::Lorem.paragraph, avg_rate: 3.2)
        @post_4 = Post.create(user: author, title: Faker::Lorem.sentence,
                              body: Faker::Lorem.paragraph, avg_rate: 4.2)
        @limit_size = 2

        get '/posts', { limit: @limit_size }
      end

      it 'responds with a 200 status' do
        expect(last_response.status).to eq 200
      end

      it 'should return limited size' do
        expect(json[:posts].size).to eq(@limit_size)
      end

      it 'should return body with max rated post firstly' do
        expect(json[:posts].first[:body]).to eq(@post_4.body)
      end

      it 'should return title with max rated post firstly' do
        expect(json[:posts].first[:title]).to eq(@post_4.title)
      end

      it 'should return body second rated post' do
        expect(json[:posts].last[:body]).to eq(@post_3.body)
      end

      it 'should return title with max rated post' do
        expect(json[:posts].last[:title]).to eq(@post_3.title)
      end
    end
  end
end
