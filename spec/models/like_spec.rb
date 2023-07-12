require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it 'belongs to a post' do
      expect(Like.reflect_on_association(:post).macro).to eq(:belongs_to)
    end

    it 'belongs to a user' do
      expect(Like.reflect_on_association(:user).macro).to eq(:belongs_to)
    end
  end

  describe 'class methods' do
    let!(:post) { Post.create(title: 'Example Title', comments_counter: 0, likes_counter: 0) }
    let!(:user) { User.create(name: 'John Doe', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico', posts_counter: 0) }
    let!(:like1) { Like.create(post:, user:) }
    let!(:like2) { Like.create(post:, user:) }
    let!(:like3) { Like.create(post:, user:) }

    it 'should have a list_all method' do
      expect(Like.list_all).to eq([{ post_id: post.id, author_id: user.id }, { post_id: post.id, author_id: user.id },
                                   { post_id: post.id, author_id: user.id }])
    end
  end

  describe 'callbacks' do
    let!(:user) { User.create(name: 'John Doe', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico', posts_counter: 0) }

    let!(:post) { Post.create(title: 'Example Title', comments_counter: 0, likes_counter: 0, author: user) }
    it 'should increment the likes_counter of the associated post after save' do
      Like.create(post:, user:)
      post.reload
      expect(post.likes_counter).to eq(1)
    end
  end
end
