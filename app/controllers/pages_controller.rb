class PagesController < ApplicationController

  before_action :authenticate_user!, only: [:admin]

  def index
    
  end

  def admin
    @courses = Course.all.order('created_at DESC').take(3)
    @users = User.all.order('created_at DESC').take(3)
    @categories = Category.all.take(4)
  end

  def cart
    if cookies[:order_id]
      @order = Order.find(cookies[:order_id])
    end
  end

  def checkout
    if user_signed_in?
      @user = current_user
    else
      @user = User.new
    end
  end

  def payment
    @user = current_user
    @order = Order.find(cookies[:order_id])
  end

end