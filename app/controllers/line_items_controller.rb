class LineItemsController < ApplicationController

  before_action :assign_course_order, 
    only: [:create_video_line_item, :create_materials_line_item]

  before_action :set_line_item, only: [:add_material, :subtract_material, :show]
  before_action :set_order, only: [:add_material, :subtract_material]

  def index
    @line_items = LineItem.all.order('created_at DESC')
  end

  def show
    
  end

  def delete
    
  end

  def sold
    @line_items = current_user.line_items
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

  def add_material

    @line_item.quantity += 1

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to cart_orders_path }
        format.js
      end
    end

  end

  def subtract_material
    if @line_item.quantity === 1

      respond_to do |format|
        if @line_item.destroy
          format.html { redirect_to cart_orders_path }
          format.js { render js: "window.location.reload()" }
        end
      end

    else

      @line_item.quantity -= 1
      respond_to do |format|
        if @line_item.save
          format.html { redirect_to cart_orders_path }
          format.js
        end
      end

    end
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    if @line_item.order.line_items.length === 0
      @line_item.order.destroy
      cookies.delete(:order_id)
    end
    redirect_to cart_orders_path, notice: 'Item successfully removed'
  end

  private

    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    def set_order
      @order = @line_item.order
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
