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

require 'test_helper'

class EnrollTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
