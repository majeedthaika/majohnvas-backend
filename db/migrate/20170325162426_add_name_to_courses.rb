class AddNameToCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :name, :text
  end
end
