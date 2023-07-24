require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = User.new(name: 'John Doe', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico', posts_counter: 0)
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user = User.new(name: nil, photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico', posts_counter: 0)
      expect(user).not_to be_valid
    end

    it 'is not valid without a bio' do
      user = User.new(name: 'John Doe', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: nil, posts_counter: 0)
      expect(user).not_to be_valid
    end

    it 'is not valid without a photo' do
      user = User.new(name: 'John Doe', photo: nil, bio: 'Teacher from Mexico', posts_counter: 0)
      expect(user).not_to be_valid
    end
  end

  describe 'associations' do
    it 'has many posts' do
      expect(User.reflect_on_association(:posts).macro).to eq(:has_many)
    end

    it 'has many comments' do
      expect(User.reflect_on_association(:comments).macro).to eq(:has_many)
    end

    it 'has many likes' do
      expect(User.reflect_on_association(:likes).macro).to eq(:has_many)
    end
  end

  describe 'instance methods' do
    let(:user) { User.create(name: 'John Doe', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico', posts_counter: 0) }
    let!(:post1) { Post.create(title: 'Post 1', comments_counter: 0, likes_counter: 0, author: user) }
    let!(:post2) { Post.create(title: 'Post 2', comments_counter: 0, likes_counter: 0, author: user) }
    let!(:post3) { Post.create(title: 'Post 3', comments_counter: 0, likes_counter: 0, author: user) }

    it 'should have a recent_posts method' do
      expect(user).to respond_to(:recent_posts)
    end

    it 'should return recent posts in descending order' do
      recent_posts = user.recent_posts(2)
      expect(recent_posts).to eq([post3, post2])
    end
  end

  describe 'class methods' do
    let!(:user1) { User.create(name: 'John Doe', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico', posts_counter: 0) }
    let!(:user2) { User.create(name: 'Jane Smith', photo: 'https://unsplash.com/photos/ABC123', bio: 'Writer from Canada', posts_counter: 1) }
    let!(:user3) { User.create(name: 'Bob Johnson', photo: 'https://unsplash.com/photos/DEF456', bio: 'Engineer from USA', posts_counter: 3) }

    it 'should have a list_all method' do
      expect(User.list_all).to eq(['John Doe', 'Jane Smith', 'Bob Johnson'])
    end

    it 'should have a delete_all method' do
      User.delete_all
      expect(User.count).to eq(0)
    end

    it 'should have a list_inactive method' do
      expect(User.list_inactive).to eq(['John Doe'])
    end

    it 'should have a list_active method' do
      expect(User.list_active).to eq(['Jane Smith', 'Bob Johnson'])
    end
  end
end
