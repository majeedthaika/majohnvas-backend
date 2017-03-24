class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses, {:id => false} do |t|
      t.string :course_code, null: false, :unique => true
      t.text :name
      t.references :teacher, foreign_key: true

      t.timestamps
    end
    execute "ALTER TABLE courses ADD PRIMARY KEY (course_code);"
  end
end
