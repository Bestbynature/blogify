class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|

      t.text :text

      t.references :author, foreign_key: { to_table: :users }
      t.references :post, foreign_key: true

      t.timestamps
    end

    unless index_exists?(:comments, :author_id)
    add_index :comments, :author_id
    end
    unless index_exists?(:comments, :post_id)
    add_index :comments, :post_id
    end
  end
end
