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

require 'test_helper'

class EnrollTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
