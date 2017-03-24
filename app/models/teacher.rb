# == Schema Information
#
# Table name: teachers
#
#  id                     :integer          not null, primary key
#  first_name             :text
#  last_name              :text
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#

class Teacher < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts, as: :author
  has_many :comments, as: :author
  has_many :courses

  def generate_jwt_teacher(exp=30.minutes.from_now.to_i)
    JwtAuth.generate_jwt({exp: exp, type: "teacher", teacher_id: self.id})
  end
end
