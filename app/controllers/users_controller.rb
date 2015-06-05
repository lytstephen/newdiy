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
  end

  def checkout
    if user_signed_in?
      @user = current_user
    else
      @user = User.new
    end
  end

  def checkout_create
    @user = User.new(user_params)
    if @user.save
      redirect_to checkout_users_path, notice: 'created user!'
    else
      redirect_to checkout_users_path, notice: 'unsuccessful create'
    end
  end

  def checkout_update
    @user = current_user
    if @user.update(user_params)
      redirect_to confirm_order_path(@order), notice: 'update success!'
    else
      redirect_to confirm_order_path(@order), notice: 'unsuccessful update'
    end
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