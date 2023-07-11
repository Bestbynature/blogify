class AddPostsCounterToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :posts_counter, :integer, default: 0
  end
end
