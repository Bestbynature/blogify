class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts, dependent: :destroy, counter_cache: true, foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  # Validations
  validates :name, presence: true
  validates :bio, presence: true
  validates :photo, presence: true
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  def recent_posts(count = 3)
    posts.order(created_at: :desc).limit(count)
  end

  # list all available users
  def self.list_all
    User.all.map(&:name)
  end

  # delete all users
  def self.delete_all
    User.all.map(&:destroy)
  end

  # list all users with no posts
  def self.list_inactive
    User.all.select { |user| user.posts_counter.zero? }.map(&:name)
  end

  # list all users with more than 1 post
  def self.list_active
    User.all.select { |user| user.posts_counter.positive? }.map(&:name)
  end
end
