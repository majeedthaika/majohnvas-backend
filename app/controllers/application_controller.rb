class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, unless: :json_request?
  before_action :check_jwt_for_current_user
  respond_to :json

  def json_request?
    request.format.json?
  end

  def check_jwt_for_current_user
    user_jwt = cookies[:user_jwt]
    user_type = JwtAuth.decode_jwt(user_jwt)["type"].to_s rescue nil
    if user_type.blank?
      render json: { success: false }, status: :unauthorized and return
    end
    @current_user_type = user_type
    if @current_user_type == "Teacher"
      self.check_jwt_for_current_teacher
    else
      self.check_jwt_for_current_student
    end
  end

  def check_jwt_for_current_student
    student_jwt = cookies[:user_jwt]
    student_id = JwtAuth.decode_jwt(student_jwt)["student_id"].to_i rescue nil
    if student_id.blank?
      render json: { success: false }, status: :unauthorized and return
    end
    @current_user_id = Student.find(student_id)
    if @current_user_id.blank?
      render json: { success: false }, status: :unauthorized and return
    end
  end

  def check_jwt_for_current_teacher
    teacher_jwt = cookies[:user_jwt]
    teacher_id = JwtAuth.decode_jwt(teacher_jwt)["teacher_id"].to_i rescue nil
    if teacher_id.blank?
      render json: { success: false }, status: :unauthorized and return
    end
    @current_user_id = Teacher.find(teacher_id)
    if @current_user_id.blank?
      render json: { success: false }, status: :unauthorized and return
    end
  end

  def current_user_type
    @current_user_type
  end

  def current_user_id
    @current_user_id
  end
end
