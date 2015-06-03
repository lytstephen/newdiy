class PagesController < ApplicationController

  before_action :authenticate_user!, only: [:admin]

  def index
    
  end

  def admin
    @courses = Course.all.order('created_at DESC').take(3)
    @users = User.all.order('created_at DESC').take(3)
    @categories = Category.all.take(4)
  end

end