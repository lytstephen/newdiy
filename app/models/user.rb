class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # buyer
  has_many :purchases, class_name: 'Order'
  has_many :purchased_line_items, through: :purchases, source: :line_items
  has_many :purchase_courses, through: :purchased_line_items, source: :course

  # seller
  has_many :courses
  has_many :sold_line_items, through: :courses, source: :line_items
  has_many :sales_orders, through: :sold_line_items, source: :order

  # validates_presence_of :first_name, :last_name,
  #       :shipping_add1, :shipping_add2,
  #       :shipping_country,
  #       :billing_add1, :billing_add2, :billing_city,
  #       :billing_country, only: :checkout

  def full_name
    first_name + " " + last_name
  end

  def earnings
    total = 0
    courses.each do |course|
      course.line_items.each do |line_item|
        total += line_item.subtotal
      end
    end
    return total
  end

  def purchase_amount
    total = 0
    purchased_line_items.each do |line_item|
      total += line_item.subtotal
    end
    return total
  end

  # def checkout
    
  # end

end
