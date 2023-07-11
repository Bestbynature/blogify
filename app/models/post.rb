class Post < ActiveRecord::Base
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, foreign_key: 'post_id'
  has_many :likes, foreign_key: 'post_id'

  def update_likes_counter
    update(likes_counter: likes.count)
  end

  def self.list_all
    Post.all.map(&:title)
  end

  def self.delete_all
    Post.all.map(&:destroy)
  end

  def self.list_most_recent
    Post.all.order(created_at: :desc).limit(5).map(&:title)
  end

  def recent_comments(count = 5)
    comments.order(created_at: :desc).limit(count)
  end

  after_save :update_posts_counter

  private

  def update_posts_counter
    author.increment!(:posts_counter)
  end
end
