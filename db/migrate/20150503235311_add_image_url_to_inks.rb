class AddImageUrlToInks < ActiveRecord::Migration
  def change
    add_column :inks, :image_url, :string
  end
end
