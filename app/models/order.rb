class Order < ActiveRecord::Base

  belongs_to :buyer, class_name: 'User', foreign_key: 'user_id'
  
  has_many :line_items, dependent: :destroy

  validates_presence_of :first_name, :last_name, :email,
                        :billing_add1, :billing_city, :billing_country,
                        on: [:update]

  def order_total
    order_total = 0
    self.line_items.each do |line_item|
      order_total += line_item.unit_price * line_item.quantity
    end
    return order_total
  end

end
