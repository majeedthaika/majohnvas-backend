class FixAuthorColumns < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :author_type, :text

    rename_column :comments, :author, :author_id
    add_column :comments, :author_type, :text
  end
end
