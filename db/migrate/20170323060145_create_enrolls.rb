class CreateEnrolls < ActiveRecord::Migration[5.0]
  def change
    create_table :enrolls do |t|
      t.references :student, foreign_key: true
      t.string :course_code

      t.timestamps
    end
  end
end
