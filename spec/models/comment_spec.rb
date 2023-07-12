require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it 'belongs to a post' do
      expect(Comment.reflect_on_association(:post).macro).to eq(:belongs_to)
    end

    it 'belongs to a user' do
      expect(Comment.reflect_on_association(:author).macro).to eq(:belongs_to)
    end
  end

  describe 'callbacks' do
    let!(:user) { User.create(name: 'John Doe', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico', posts_counter: 0) }

    it 'should increment the comments_counter of the associated post after save' do
      post = Post.create(title: 'Example Title', comments_counter: 0, likes_counter: 0, author: user)
      Comment.create(text: 'New Comment', post:, author: user)
      post.reload
      expect(post.comments_counter).to eq(1)
    end
  end

  describe 'class methods' do
    let!(:post) { Post.create(title: 'Example Title', comments_counter: 0, likes_counter: 0) }
    let!(:user) { User.create(name: 'John Doe', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico', posts_counter: 0) }
    let!(:comment1) { Comment.create(text: 'Comment 1', post:, author: user) }
    let!(:comment2) { Comment.create(text: 'Comment 2', post:, author: user) }
    let!(:comment3) { Comment.create(text: 'Comment 3', post:, author: user) }

    it 'should have a list_all method' do
      expect(Comment.list_all).to eq(['Comment 1', 'Comment 2', 'Comment 3'])
    end

    it 'should have a delete_all method' do
      Comment.delete_all
      expect(Comment.count).to eq(0)
    end
  end
end
