class Post < ActiveRecord::Base
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, foreign_key: 'post_id', counter_cache: true
  has_many :likes, foreign_key: 'post_id', counter_cache: true

  # Validations
  validates :title, presence: true, length: { maximum: 250 }
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0 }
  validates :comments_counter, numericality: { greater_than_or_equal_to: 0 }
  
  def self.delete_all
    destroy_all
  end

  def recent_comments(count = 5)
    comments.order(created_at: :desc).limit(count)
  end

  def liked_by?(user)
    likes.exists?(user: user)
  end

  def find_like_by_user(user)
    likes.find_by(user: user)
  end

  after_create :increment_author_posts_counter

  private

  def increment_author_posts_counter
    author.increment!(:posts_counter)
  end
end
