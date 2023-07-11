class Like < ActiveRecord::Base
    belongs_to :post, foreign_key: 'post_id'
    belongs_to :author, class_name: 'User', foreign_key: 'author_id'

    def self.update_likes_counter(post_id)
        post = Post.find(post_id)
        post.update(likes_counter: post.likes.count)
      end

      def self.list_all
        Like.all.map { |like| like.body }
      end
    
      def self.delete_all
        Like.all.map { |like| like.destroy }
      end
end
