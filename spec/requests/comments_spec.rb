require 'rails_helper'

RSpec.describe 'CommentsController', type: :request do
  describe 'GET #index' do
    let(:user) { User.create(name: 'John Doe', photo: 'https://source.unsplash.com/glRqyWJgUeY', bio: 'Teacher from Mexico', posts_counter: 0) }
    let(:post) { Post.create(title: 'Post Title', text: 'This is the content of the post.', author: user) }
    let!(:comment1) { Comment.create(text: 'First comment', post: post, user: user) }
    let!(:comment2) { Comment.create(text: 'Second comment', post: post, user: user) }

    it 'returns a successful response' do
      get user_post_comments_path(user, post)
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get user_post_comments_path(user, post)
      expect(response).to render_template(:index)
    end

    it 'displays placeholder text in the response body' do
      get user_post_comments_path(user, post)
      expect(response.body).to include('Comments')
      expect(response.body).to include(comment1.text)
      expect(response.body).to include(comment2.text)
    end
  end

  describe 'GET #show' do
    let(:user) { User.create(name: 'John Doe', photo: 'https://source.unsplash.com/glRqyWJgUeY', bio: 'Teacher from Mexico', posts_counter: 0) }
    let(:post) { Post.create(title: 'Post Title', text: 'This is the content of the post.', author: user) }
    let(:comment) { Comment.create(text: 'This is a comment.', post: post, user: user) }

    it 'returns a successful response' do
      get user_post_comment_path(user, post, comment)
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get user_post_comment_path(user, post, comment)
      expect(response).to render_template(:show)
    end

    it 'displays placeholder text in the response body' do
      get user_post_comment_path(user, post, comment)
      expect(response.body).to include(comment.text)
    end
  end
end