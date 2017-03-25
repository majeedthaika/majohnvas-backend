class RemoveNameFromCourses < ActiveRecord::Migration[5.0]
  def change
    remove_column :courses, :name, :text
  end
end
