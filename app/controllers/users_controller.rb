class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update]
  before_action :set_order, only: [:checkout_create, :checkout_update]

  def index
    @users = User.all.order('created_at DESC')
  end

  def show

  end

  def edit
    
  end

  def update
    if @user.update_without_password(user_params)
      redirect_to user_path(@user), notice: 'User updated successfully!'
    else
      render 'edit'
    end
  end

  def dashboard
    @courses = current_user.courses.order('created_at DESC').take(3)
    @orders = current_user.orders.order('created_at DESC').take(3)
    @orders_to_ship = current_user.line_items.where(shipping_status: 'pending').order('created_at DESC').take(3)
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, 
        :password_confirmation, :first_name, :last_name,
        :phone, :shipping_add1, :shipping_add2, :shipping_city,
        :shipping_state, :shipping_zip, :shipping_country,
        :billing_add1, :billing_add2, :billing_city,
        :billing_state, :billing_zip, :billing_country)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def set_order
      @order = Order.find(cookies[:order_id])
    end

end