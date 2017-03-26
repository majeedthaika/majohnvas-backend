class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.where(:post => @post)
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  # def new
  #   @comment = Comment.new
  # end

  # GET /comments/1/edit
  # def edit
  # end

  # POST /comments
  # POST /comments.json
  def create
    @comment = nil
    if @current_user_type == "Teacher"
      teacher = Teacher.find(@current_user_id)
      @comment = teacher.comments.build(:content => comment_params, :post => @post)
    else
      student = Student.find(@current_user_id)
      @comment = student.comments.build(:content => comment_params, :post => @post)
    end
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  # def update
  #   respond_to do |format|
  #     if @comment.update(comment_params)
  #       format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @comment }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @comment.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /comments/1
  # DELETE /comments/1.json
  # def destroy
  #   @comment.destroy
  #   respond_to do |format|
  #     format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    def set_post
      @post = Post.find(params[:post_id])
      set_course
    end

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
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:content)
    end
end
