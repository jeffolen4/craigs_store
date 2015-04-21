class AddLevelToProductCategories < ActiveRecord::Migration
  def change
    add_column :product_categories, :level, :integer
  end
end
