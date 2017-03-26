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
  before_create :generate_code
  self.primary_key = :course_code
  belongs_to :teacher
  has_many :enrolls
  has_many :students, :through => :enrolls
  has_many :posts

  def generate_code
    begin
      self.course_code = (0...5).map { ('A'..'Z').to_a[rand(26)] }.join
    end while Course.where(course_code: self.course_code).exists?
  end
end
