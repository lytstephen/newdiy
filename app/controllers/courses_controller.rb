class CoursesController < ApplicationController

  before_action :set_course, only: [:show, :edit, :update]

  def index
    @categories = Category.all
    @courses = Course.all
  end

  def show

  end

  def edit

  end

  def update
    if @course.update(course_params)
      redirect_to course_path(@course), notice: 'The course has been updated successfully!'
    else
      render 'edit'
    end
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    @course.user = current_user
    if @course.save
      redirect_to course_path(@course), notice: 'The course has been created successfully!'
    else
      render 'new'
    end
  end

  private

    def course_params
      params.require(:course).permit(:title, :description, :video_link, :materials, :video_cost,
        :material_cost, :featured_image, :image1, :image2)
    end

    def set_course
      @course = Course.find(params[:id])
    end
end
