class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = User.all
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

  private

    def user_params
      params.require(:user).permit(:email, :password, 
        :password_confirmation, :first_name, :last_name,
        :phone, :shipping_add1, :shipping_add2,
        :shipping_state, :shipping_zip, :shipping_country,
        :billing_add1, :billing_add2, :billing_city,
        :billing_state, :billing_zip, :billing_country)
    end

    def set_user
      @user = User.find(params[:id])
    end

end