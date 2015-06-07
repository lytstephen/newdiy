class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true, foreign_key: true
      t.string :pmt_method
      t.string :pmt_status
      t.string :shipping_add1
      t.string :shipping_add2
      t.string :shipping_city
      t.string :shipping_state
      t.string :shipping_zip
      t.string :shipping_country
      t.string :billing_add1
      t.string :billing_add2
      t.string :billing_city
      t.string :billing_state
      t.string :billing_zip
      t.string :billing_country
      t.string :first_name
      t.string :last_name
      t.string :email
      t.boolean :completed, default: false

      t.timestamps null: false
    end
  end
end
