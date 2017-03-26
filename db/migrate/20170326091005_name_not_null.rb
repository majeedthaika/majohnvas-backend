class NameNotNull < ActiveRecord::Migration[5.0]
  def change
    change_column_null :students, :first_name, false
    change_column_null :students, :last_name, false

    change_column_null :teachers, :first_name, false
    change_column_null :teachers, :last_name, false
  end
end
