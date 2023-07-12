class Like < ActiveRecord::Base
  belongs_to :post, foreign_key: 'post_id'
  belongs_to :user, foreign_key: 'author_id'

  def self.list_all
    Like.all.map { |like| { post_id: like.post_id, author_id: like.author_id } }
  end

  after_save :update_likes_counter

  private

  def update_likes_counter
    post.increment!(:likes_counter)
  end
end
