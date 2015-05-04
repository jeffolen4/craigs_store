class CreateInks < ActiveRecord::Migration
  def change
    create_table :inks do |t|
      t.string :brand
      t.string :short_description
      t.text :long_description
      t.float :price
      t.integer :unit
      t.string :sku

      t.timestamps null: false
    end
  end
end
