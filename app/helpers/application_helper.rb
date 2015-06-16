module ApplicationHelper

  def items_in_cart
    if cookies[:order_id]
      order = Order.find(cookies[:order_id])
      return order.line_items.length
    else
      return 0;
    end
  end

  def is_admin?
    if user_signed_in?
      user = User.find(current_user.id)
      return user.admin
    end
  end
  
end
