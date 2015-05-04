class RenameTypeColumnInPrinters < ActiveRecord::Migration
  def change
    rename_column :printers, :type, :printer_type
  end
end
