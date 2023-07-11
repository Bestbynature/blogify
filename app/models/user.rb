class User < ActiveRecord::Base
    has_many :posts, foreign_key: 'author_id'
    has_many :comments, foreign_key: 'author_id'
    has_many :likes, foreign_key: 'author_id'

    def recent_posts(count = 3)
        posts.order(created_at: :desc).limit(count)
      end

      # list all available users
      def self.list_all
        User.all.map { |user| user.name }
      end

      # delete all users
      def self.delete_all
        User.all.map { |user| user.destroy }
      end

      # list all users with no posts
      def self.list_inactive
        User.all.select { |user| user.posts.count == 0 }.map { |user| user.name }
      end

      # list all users with more than 1 post
      def self.list_active
        User.all.select { |user| user.posts.count > 1 }.map { |user| user.name }
      end

end
