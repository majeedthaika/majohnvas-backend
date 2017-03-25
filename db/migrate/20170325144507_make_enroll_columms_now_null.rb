class MakeEnrollColummsNowNull < ActiveRecord::Migration[5.0]
  def change
    change_column_null :enrolls, :student_id, false
    change_column_null :enrolls, :course_code, false
  end
end
