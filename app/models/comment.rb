class Comment < ActiveRecord::Base
  belongs_to :post, foreign_key: 'post_id'
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  def self.list_all
    Comment.all.map(&:text)
  end

  def self.delete_all
    Comment.all.map(&:destroy)
  end

  after_save :update_comments_counter

  private

  def update_comments_counter
    post.increment!(:comments_counter)
  end
end
