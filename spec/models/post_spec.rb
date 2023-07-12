require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = User.create(name: 'John Doe', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico',
                         posts_counter: 0)
      post = Post.new(title: 'Example Title', comments_counter: 0, likes_counter: 0, author: user)
      expect(post).to be_valid
    end

    it 'is not valid without a title' do
      post = Post.new(title: nil, comments_counter: 0, likes_counter: 0)
      expect(post).to_not be_valid
    end

    it 'is not valid with a title longer than 250 characters' do
      post = Post.new(title: 'A' * 251, comments_counter: 0, likes_counter: 0)
      expect(post).to_not be_valid
    end

    it 'is not valid with a negative comments_counter' do
      post = Post.new(title: 'Example Title', comments_counter: -1, likes_counter: 0)
      expect(post).to_not be_valid
    end

    it 'is not valid with a negative likes_counter' do
      post = Post.new(title: 'Example Title', comments_counter: 0, likes_counter: -1)
      expect(post).to_not be_valid
    end
  end

  describe 'associations' do
    it 'belongs to an author' do
      expect(Post.reflect_on_association(:author).macro).to eq(:belongs_to)
    end

    it 'has many comments' do
      expect(Post.reflect_on_association(:comments).macro).to eq(:has_many)
    end

    it 'has many likes' do
      expect(Post.reflect_on_association(:likes).macro).to eq(:has_many)
    end
  end

  describe 'instance methods' do
    let(:user) { User.create(name: 'John Doe', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico', posts_counter: 0) }
    let(:post) { Post.new(title: 'Example Title', comments_counter: 0, likes_counter: 0, author: user) }

    it 'should have an update_likes_counter method' do
      expect(post).to respond_to(:update_likes_counter)
    end

    it 'should have a recent_comments method' do
      expect(post).to respond_to(:recent_comments)
    end
  end

  describe 'class methods' do
    let!(:post1) { Post.create(title: 'Post 1', comments_counter: 0, likes_counter: 0) }
    let!(:post2) { Post.create(title: 'Post 2', comments_counter: 0, likes_counter: 0) }
    let!(:post3) { Post.create(title: 'Post 3', comments_counter: 0, likes_counter: 0) }

    it 'should have a delete_all method' do
      Post.delete_all
      expect(Post.count).to eq(0)
    end
  end
end
