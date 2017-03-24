# == Schema Information
#
# Table name: enrolls
#
#  id          :integer          not null, primary key
#  student_id  :integer
#  course_code :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Enroll < ApplicationRecord
  belongs_to :student
  belongs_to :course, :foreign_key => 'course_code'
end
