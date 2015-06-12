class AddBillingSameToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :billing_same, :boolean
  end
end
