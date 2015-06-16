class Admin::OrdersController < ApplicationController
  
  before_action :set_order, only: [:show]

  def index
    @orders = Order.all.order('created_at DESC')
  end

  def show
    
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
