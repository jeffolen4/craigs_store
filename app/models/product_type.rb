class ProductType < ActiveRecord::Base
  has_many :ProductCategories
end
