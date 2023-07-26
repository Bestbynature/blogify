class Comment < ActiveRecord::Base
  belongs_to :post, foreign_key: 'post_id'
  belongs_to :user, foreign_key: 'user_id'

  def self.list_all
    Comment.all.map(&:text)
  end

  def self.delete_all
    Comment.all.map(&:destroy)
  end

  private

  def update_comments_counter
    post.increment!(:comments_counter)
  end
end
