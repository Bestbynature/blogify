class Like < ActiveRecord::Base
  belongs_to :post, foreign_key: 'post_id'
  belongs_to :user, foreign_key: 'user_id'

  def self.list_all
    Like.all.map { |like| { post_id: like.post_id, user_id: like.user_id } }
  end

  after_save :update_likes_counter
  after_destroy :decrement_likes_counter

  def update_likes_counter
    post.increment!(:likes_counter) if post
  end

  def decrement_likes_counter
    if post
      post.decrement!(:likes_counter)
    else
      # The post is already destroyed, avoid decrementing the counter.
      # This can happen when the Like is deleted after its post is destroyed.
      # Do nothing in this case.
    end
  end

  # def update_likes_counter
  #   post.increment!(:likes_counter)
  # end
end
