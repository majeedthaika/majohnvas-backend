# == Schema Information
#
# Table name: courses
#
#  course_code :string           not null, primary key
#  name        :text
#  teacher_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Course < ApplicationRecord
  self.primary_key = :course_code
  belongs_to :teacher
  has_many :students, :through => :enrolls
  has_many :posts
end
