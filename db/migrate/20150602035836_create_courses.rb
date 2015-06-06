class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.references :category, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :title
      t.string :description
      t.string :video_link
      t.text :materials
      t.integer :video_cost
      t.integer :material_cost
      t.boolean :approved, default: false
      t.boolean :visibility, default: true
      t.boolean :in_stock

      t.timestamps null: false
    end
  end
end
