class CreatePrinters < ActiveRecord::Migration
  def change
    create_table :printers do |t|
      t.string :brand
      t.string :model
      t.string :type

      t.timestamps null: false
    end
  end
end
