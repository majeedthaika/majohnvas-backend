# == Schema Information
#
# Table name: comments
#
#  id          :integer          not null, primary key
#  content     :text
#  post_id     :integer
#  author_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  author_type :text
#

class Comment < ApplicationRecord
  belongs_to :author, polymorphic: true
  belongs_to :post
end
