class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.text :title
      t.text :content
      t.string :course_code
      t.integer :author

      t.timestamps
    end
  end
end