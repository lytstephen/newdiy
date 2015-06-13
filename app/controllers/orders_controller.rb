class OrdersController < ApplicationController
  
  before_action :set_order, only: [:show, :update, :checkout, :checkout_signup, :paid, :complete]

  def index
    @orders = Order.all.order('created_at DESC')
  end

  def show
    
  end

  def edit
  end

  def update
    if @order.update(order_params)
      redirect_to confirm_order_path(@order)
    else
      render 'checkout'
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

  def cart
    if cookies[:order_id]
      @order = Order.find(cookies[:order_id])
    end
  end

  def checkout
    @order.user_id = current_user.id
    @order.first_name = current_user.first_name
    @order.last_name = current_user.last_name
    @order.email = current_user.email
    @order.save
  end

  def checkout_signup

  end

  def confirm
    @user = current_user
    @order = Order.find(params[:id])
  end

  def purchase_history
    @purchases = current_user.purchases
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
