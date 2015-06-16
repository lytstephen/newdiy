class UsersController < ApplicationController

  before_action :set_user, only: [:purchased_courses]

  def dashboard
    @courses = current_user.courses.order('created_at DESC').take(3)
    @line_items_to_ship = current_user.sold_line_items.where(
      item_type: 'materials', shipping_status: 'pending'
    )
    @purchases = current_user.purchases.take(3)
  end

  def purchased_courses
    @orders = @user.purchases.order('created_at')
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, 
        :password_confirmation, :first_name, :last_name,
        :phone, :billing_same,
        :shipping_add1, :shipping_add2, :shipping_city,
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