require 'rails_helper'

RSpec.describe 'PostsController', type: :request do
  describe 'GET #index' do
    let(:user) { User.create(name: 'John Doe', photo: 'https://source.unsplash.com/glRqyWJgUeY', bio: 'Teacher from Mexico', posts_counter: 0) }
    let!(:post1) { Post.create(title: 'Post 1', text: 'This is the first post.', author: user) }
    let!(:post2) { Post.create(title: 'Post 2', text: 'This is the second post.', author: user) }

    it 'returns a successful response' do
      get user_posts_path(user)
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get user_posts_path(user)
      expect(response).to render_template(:index)
    end

    it 'displays placeholder text in the response body' do
      get user_posts_path(user)
      expect(response.body).to include('Posts')
      expect(response.body).to include(post1.text)
      expect(response.body).to include(post2.text)
    end
  end

  describe 'GET #show' do
    let(:user) { User.create(name: 'John Doe', photo: 'https://source.unsplash.com/glRqyWJgUeY', bio: 'Teacher from Mexico', posts_counter: 0) }
    let(:post) { Post.create(title: 'Post Title', text: 'This is the content of the post.', author: user) }

    it 'returns a successful response' do
      get user_post_path(user, post)
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get user_post_path(user, post)
      expect(response).to render_template(:show)
    end

    it 'displays placeholder text in the response body' do
      get user_post_path(user, post)
      expect(response.body).to include('Text')
      expect(response.body).to include(post.text)
    end
  end
end
