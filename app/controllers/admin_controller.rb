class AdminController < ApplicationController

  def index
    @courses = Course.all.order('created_at DESC').take(3)
    @users = User.all.order('created_at DESC').take(3)
    @categories = Category.all.take(4)
    @orders = Order.where(completed: true).order('created_at DESC').take(3)
  end

  def manage_courses
    @courses = Course.all.order('created_at DESC')
  end

  def upload_course
    redirect_to admin_users_path, alert: 'Please click "details" on a user to upload for him:'
  end
  
end
