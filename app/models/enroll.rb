# == Schema Information
#
# Table name: enrolls
#
#  id          :integer          not null, primary key
#  student_id  :integer          not null
#  course_code :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Enroll < ApplicationRecord
  belongs_to :student
  belongs_to :course, :foreign_key => 'course_code'
end
