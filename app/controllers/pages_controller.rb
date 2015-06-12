class PagesController < ApplicationController

  before_action :authenticate_user!, only: [:admin]

  def index
    @courses = Course.all.order('created_at DESC').take(4)
  end

  def admin
    @courses = Course.all.order('created_at DESC').take(3)
    @users = User.all.order('created_at DESC').take(3)
    @categories = Category.all.take(4)
    @orders = Order.all.order('created_at DESC').take(3)
  end

  def faq
  end

  def about
  end

  def contact
  end

  def readme
  end

end