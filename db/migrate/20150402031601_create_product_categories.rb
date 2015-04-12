class CreateProductCategories < ActiveRecord::Migration
  def change
    create_table :product_categories do |t|
      t.string :name
      t.belongs_to :product_type, index: true

      t.timestamps null: false
    end
    add_foreign_key :product_categories, :product_types
  end
end
