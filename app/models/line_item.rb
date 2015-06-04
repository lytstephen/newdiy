class LineItem < ActiveRecord::Base

  belongs_to :order
  belongs_to :course

  def subtotal
    quantity * unit_price
  end
  
end
