module ApplicationHelper

  def items_in_cart
    if cookies[:order_id]
      order = Order.find(cookies[:order_id])
      return order.line_items.length
    else
      return 0;
    end
  end
  
end
