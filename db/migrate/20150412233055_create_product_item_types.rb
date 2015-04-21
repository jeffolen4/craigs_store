class CreateProductItemTypes < ActiveRecord::Migration
  def change
    create_table :product_item_types do |t|
      t.string :name
      t.belongs_to :product_category, index: true

      t.timestamps null: false
    end
    add_foreign_key :product_item_types, :product_categories
  end
end
