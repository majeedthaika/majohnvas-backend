class PostsController < ApplicationController
  before_action :set_course
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.where(:course => @course)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  # def new
  #   @post = Post.new
  # end

  # GET /posts/1/edit
  # def edit
  # end

  # POST /posts
  # POST /posts.json
  def create
    @post = nil
    if @current_user_type == "Teacher"
      teacher = Teacher.find(@current_user_id)
      @post = teacher.posts.build(:title => post_params[0], :content => post_params[1], :course => @course)
    else
      student = Student.find(@current_user_id)
      @post = student.posts.build(:title => post_params[0], :content => post_params[1], :course => @course)
    end
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created }
      else
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  # def update
  #   respond_to do |format|
  #     if @post.update(post_params)
  #       format.html { redirect_to @post, notice: 'Post was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @post }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @post.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /posts/1
  # DELETE /posts/1.json
  # def destroy
  #   @post.destroy
  #   respond_to do |format|
  #     format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    def set_course
      @course = Course.find(params[:course_id])
      check_course_permission
    end

    def check_course_permission
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

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require([:title, :content])
    end
end
