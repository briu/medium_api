require 'spec_helper'

describe PostsController, :type => :api do
  describe '#create' do
    context 'with valid params' do
      before do
        @users_count = User.count
        @posts_count = Post.count
        @params = { post: { title: 'test', body: 'test body' },
                    author: { login: 'shakespeare' } }.with_indifferent_access
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
        @params = { post: { title: '', body: 'test body' },
                    author: { login: 'shakespeare2' } }.with_indifferent_access
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

    context 'with not valid authour parameter' do
      before do
        @users_count = User.count
        @posts_count = Post.count
        @params = { post: { title: 'test', body: 'test body' },
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
end
