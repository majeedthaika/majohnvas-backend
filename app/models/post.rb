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

class Post < ApplicationRecord
  belongs_to :author, polymorphic: true
  belongs_to :course, :foreign_key => 'course_code'
  has_many :comments
end
