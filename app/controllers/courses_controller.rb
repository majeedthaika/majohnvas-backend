class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    if @current_user_type == "Teacher"
      @courses = Course.where(:teacher => @current_user_id)
    else
      @courses = Student.find(@current_user_id).courses.uniq
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    if @current_user_type == "Teacher"
      if @course.teacher != @current_user_id
        render json: { success: false }, status: :unauthorized
      end
    else
      if Enroll.find_by(:student_id => @current_user_id, :course => @course).blank?
        render json: { success: false }, status: :unauthorized
      end
    end
  end

  # GET /courses/new
  # def new
  # end

  # GET /courses/1/edit
  # def edit
  #   if @current_user_type != "Teacher"
  #     render json: { success: false }, status: :unauthorized
  #   end
  # end

  # POST /courses
  # POST /courses.json
  def create
    if @current_user_type == "Teacher"

      @course = Course.new
      @course.name = course_params
      @course.teacher = @current_user_id

      respond_to do |format|
        if @course.save
          format.html { redirect_to @course, notice: 'Course was successfully created.' }
          format.json { render :show, status: :created, location: @course }
        else
          format.json { render json: @course.errors, status: :unprocessable_entity }
        end
      end
    else
      render json: { success: false }, status: :unauthorized
    end
  end

  # POST /courses/join.json
  def join
    if @current_user_type == "Student"
      @course = Course.find(join_course_params) rescue nil
      if @course.blank?
        render json: { success: false }, status: :unauthorized
      else
        @enroll = Enroll.new
        @enroll.course = @course
        @enroll.student = @current_user_id

        respond_to do |format|
          if @enroll.save
            format.json { render json: @course }
          else
            format.json { render json: @enroll.errors, status: :unprocessable_entity }
          end
        end
      end
    else
      render json: { success: false }, status: :unauthorized
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  # def update
  #   respond_to do |format|
  #     if @course.update(course_params)
  #       format.html { redirect_to @course, notice: 'Course was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @course }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @course.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /courses/1
  # DELETE /courses/1.json
  # def destroy
  #   @course.destroy
  #   respond_to do |format|
  #     format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:course_code])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def join_course_params
      params.require(:course_code)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:name)
    end
end
