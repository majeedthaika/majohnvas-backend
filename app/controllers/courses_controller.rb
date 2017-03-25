class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    if @current_user_type == "teacher"
      @courses = Course.where(:teacher => @current_user_id)
    else
      @courses = Student.find(@current_user_id).courses.uniq
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    if @current_user_type == "teacher"
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
  #   if @current_user_type != "teacher"
  #     render json: { success: false }, status: :unauthorized
  #   end
  # end

  # POST /courses
  # POST /courses.json
  def create
    if @current_user_type == "teacher"
      code = ""
      loop do
        code = (0...5).map { ('A'..'Z').to_a[rand(26)] }.join
        duplicate = Course.find(course_code = code) rescue nil
        break if duplicate.blank?
      end

      @course = Course.new
      @course.name = course_params
      @course.course_code = code
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
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:name)
    end
end
