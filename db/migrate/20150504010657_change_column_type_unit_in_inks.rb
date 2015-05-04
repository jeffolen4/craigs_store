class ChangeColumnTypeUnitInInks < ActiveRecord::Migration
  def change
    change_column :inks, :unit, :string
  end
end
