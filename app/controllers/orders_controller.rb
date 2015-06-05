class OrdersController < ApplicationController
  
  before_action :assign_course_order, only: [:create_video_line_item, :create_materials_line_item]
  before_action :set_order, only: [:show, :update]

  def index
    if current_user.admin === true
      @orders = Order.all.order('created_at DESC')
    else
      @line_items = current_user.line_items.order('shipping_status')
    end
  end

  def show
    
  end

  def edit
  end

  def update
    @order.pmt_status = 'paid'
    if @order.update(order_params)
      redirect_to success_orders_path
      cookies.delete(:order_id)
    else
      render 'confirm_order', notice: 'Order Failed.'
    end
  end

  def create_video_line_item

    current_item = LineItem.find_by(order_id: @order.id, course_id: @course.id, item_type: 'video')
    if current_item
      redirect_to course_path(@course), alert: "You already have this video in your cart!"
    else 
      @line_item = @order.line_items.build(course_id: @course.id,
                                           item_type: 'video',
                                           unit_price: @course.video_cost,
                                           quantity: 1,
                                           shipping_status: 'N/A')
      if @line_item.save
        redirect_to course_path(@course), notice: "Item Added to Cart successfully!"
      else
        render course_path(@course), alert: "Item was not added to cart"
      end
    end
  end

  def create_materials_line_item

    current_item = LineItem.find_by(order_id: @order.id, course_id: @course.id, item_type: 'materials')
    if current_item
      current_item.quantity += 1
      if current_item.save
        redirect_to course_path(@course), notice: "Item Added to Cart successfully!"
      else
        render course_path(@course), alert: "Item was not added to cart"
      end        
    else 
      @line_item = @order.line_items.build(course_id: @course.id,
                                           item_type: 'materials',
                                           unit_price: @course.material_cost,
                                           quantity: 1,
                                           shipping_status: 'pending')
      if @line_item.save
        redirect_to course_path(@course), notice: "Item Added to Cart successfully!"
      else
        render course_path(@course), alert: "Item was not added to cart"
      end
    end
  end

  def confirm
    @user = current_user
    @order = Order.find(params[:id])
  end

  def purchase_history
    @orders = current_user.orders.order('created_at')
  end

  private

    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:user_id, :pmt_method, 
        :shipping_add1, :shipping_add2, :shipping_city,
        :shipping_state, :shipping_zip, :shipping_country,
        :billing_add1, :billing_add2, :billing_city,
        :billing_state, :billing_zip, :billing_country )
    end

    def assign_course_order

      @course = Course.find(params[:course_id])

      # if there's a cookie, then just roll with it
      if cookies[:order_id]
        @order = Order.find(cookies[:order_id])

      # if no cookie, let see if user is signed
      elsif user_signed_in?
        # if he is, let see if he has unfinished orders
        # @order = Order.find_by(user_id: current_user.id, completed: false)
        # if he didn't have unfinished order, let's create one for him
        # if @order.nil?
          @order = Order.create(user_id: current_user.id)
        # end
        # and set the cookies for him
        cookies[:order_id] = @order.id

      # if there's no cookie, and the user is not signed in, then just create order with no user
      # and set the cookie
      else
        @order = Order.create
        cookies[:order_id] = @order.id
      end

    end

end
