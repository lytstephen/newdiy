class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.references :order, index: true, foreign_key: true
      t.references :course, index: true, foreign_key: true
      t.string :shipping_status
      t.string :item_type
      t.integer :unit_price
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
