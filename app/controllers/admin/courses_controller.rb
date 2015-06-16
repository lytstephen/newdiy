class Admin::CoursesController < ApplicationController

  before_action :set_course, only: [:show, :edit, :update, 
                                    :remove_featured, :remove_image1, :remove_image2]

  def edit
    @categories = Category.all.order('name')
  end

  def update
    if @course.update(course_params)
      redirect_to edit_admin_course_path(@course), 
      notice: 'The course has been updated successfully!'
    else
      render 'edit'
    end
  end

  def new
    @categories = Category.all.order('name')
    @course = Course.new
    @user_id = params[:user_id]
  end

  # uses courses#create action instead
  # def create

  # end

  def manage
    @courses = Course.all.order('created_at DESC')
  end

  def remove_featured
    @course.featured_image = nil
    if @course.save
      redirect_to edit_admin_course_path(@course), notice: 'Image Removed'
    end
  end

  def remove_image1
    @course.image1 = nil
    if @course.save
      redirect_to edit_admin_course_path(@course), notice: 'Image Removed'
    end  
  end

  def remove_image2
    @course.image2 = nil
    if @course.save
      redirect_to edit_admin_course_path(@course), notice: 'Image Removed'
    end  
  end

  private

    def course_params
      params.require(:course).permit(:user_id, :title, :description, :video_link, :materials, :video_cost,
        :material_cost, :featured_image, :image1, :image2, {:category_ids => []})
    end

    def set_course
      @course = Course.find(params[:id])
    end

end