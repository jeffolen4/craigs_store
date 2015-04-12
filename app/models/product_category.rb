class ProductCategory < ActiveRecord::Base
  belongs_to :ProductType
end
