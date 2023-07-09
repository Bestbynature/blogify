class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :text
      t.integer :comments_counter
      t.integer :likes_counter

      t.references :author, foreign_key: { to_table: :users }

      t.timestamps
    end

    unless index_exists?(:posts, :author_id)
    add_index :posts, :author_id
  end
end
end