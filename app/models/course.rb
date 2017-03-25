# == Schema Information
#
# Table name: courses
#
#  course_code :string           not null, primary key
#  teacher_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  name        :text
#

class Course < ApplicationRecord
  self.primary_key = :course_code
  belongs_to :teacher
  has_many :enrolls
  has_many :students, :through => :enrolls
  has_many :posts
end
