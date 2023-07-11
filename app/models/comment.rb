class Comment < ActiveRecord::Base
  belongs_to :post, foreign_key: 'post_id'
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  def self.update_comments_counter(post_id)
    post = Post.find(post_id)
    post.update(comments_counter: post.comments.count)
  end

  def self.list_all
    Comment.all.map(&:text)
  end

  def self.delete_all
    Comment.all.map(&:destroy)
  end
end
