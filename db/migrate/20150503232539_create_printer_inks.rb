class CreatePrinterInks < ActiveRecord::Migration
  def change
    create_table :printer_inks do |t|
      t.integer :printer_id
      t.integer :ink_id

      t.timestamps null: false
    end
  end
end
