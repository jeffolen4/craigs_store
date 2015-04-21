class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.float :price
      t.string :unit
      t.string :brand
      t.integer :cat_level_1
      t.integer :cat_level_2
      t.integer :cat_level_3
      t.string :url

      t.timestamps null: false
    end
  end
end
