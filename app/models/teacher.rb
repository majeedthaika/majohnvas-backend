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
  before_create :generate_id
  self.primary_key = :id
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts, as: :author, dependent: :destroy
  has_many :comments, as: :author
  has_many :courses

  def generate_jwt_teacher(exp=30.minutes.from_now.to_i)
    JwtAuth.generate_jwt({exp: exp, type: "Teacher", teacher_id: self.id})
  end

  def generate_id
    begin
      self.id = SecureRandom.random_number(1_000_000_000)
    end while (Teacher.where(id: self.id).exists? || Student.where(id: self.id).exists?)
  end
end
