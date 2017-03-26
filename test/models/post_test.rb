# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  title       :text
#  content     :text
#  course_code :string
#  author_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  author_type :text
#

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
