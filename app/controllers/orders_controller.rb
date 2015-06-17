class OrdersController < ApplicationController

  load_and_authorize_resource only: [:purchase_history, :show]
  
  before_action :set_order, only: [:show, :update, :checkout, :checkout_signup, :paid, :complete]

  def purchase_history
    @purchases = current_user.purchases
  end

  def show
    
  end

  def cart
    if cookies[:order_id]
      @order = Order.find(cookies[:order_id])
    end
  end

  def checkout
    @order.update_attribute('user_id', current_user.id)
  end

  def checkout_signup

  end

  # checkout update order information
  def update
    if @order.update(order_params)
      redirect_to confirm_order_path(@order)
    else
      if user_signed_in?
        render 'checkout'
      else
        render 'checkout_signup'
      end
    end
  end

  def confirm
    @order = Order.find(params[:id])

    # if user not logged in and theres videos in the order
    if user_signed_in? == false
      @order.line_items.each do |line_item|
        if line_item.item_type == 'video'
          redirect_to new_user_session_path, 
            alert: 'You cannot purchase video as Guest. Please signup or login first.'
        end
      end
    end

    # if shipping address not filled and theres materials in the order
    if @order.shipping_add1.blank? and @order.billing_same != true
      @order.line_items.each do |line_item|
        if line_item.item_type = 'materials'
          redirect_to (user_signed_in? ? checkout_order_path : checkout_signup_order_path),
            alert: 'Shipping Address Required for Materials Orders'
        end
      end
    end

  end

  def complete
    @order.pmt_status = 'paid'
    @order.completed = true
    if @order.update(order_params)
      redirect_to success_orders_path
      cookies.delete(:order_id)
    else
      render 'confirm_order', notice: 'Order Failed.'
    end
  end

  private

    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:user_id, :first_name, :last_name,
        :email, :pmt_method, 
        :shipping_add1, :shipping_add2, :shipping_city,
        :shipping_state, :shipping_zip, :shipping_country,
        :billing_add1, :billing_add2, :billing_city,
        :billing_state, :billing_zip, :billing_country,
        :billing_same )
    end

end
