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

require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
