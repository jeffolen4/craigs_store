class AddUrlToProductCategories < ActiveRecord::Migration
  def change
    add_column :product_categories, :url, :string
  end
end
