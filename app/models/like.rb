class Like < ActiveRecord::Base
  belongs_to :post, foreign_key: 'post_id'
  belongs_to :user

  def self.list_all
    Like.all.map(&:body)
  end

  def self.delete_all
    Like.all.map(&:destroy)
  end

  after_save :update_likes_counter

  private

  def update_likes_counter
    author.increment!(:likes_counter)
  end
end
