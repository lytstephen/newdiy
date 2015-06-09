class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :courses
  has_many :orders

  has_many :line_items, through: :orders

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

  def purchases
    total = 0
    line_items.each do |line_item|
      total += line_item.subtotal
    end
    return total
  end

  # def checkout
    
  # end

end
