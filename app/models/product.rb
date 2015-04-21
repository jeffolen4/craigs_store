class Product < ActiveRecord::Base

  

  scope :level_one_products, lambda { |cat_level_1| where("cat_level_1 = ?", cat_level_1.to_i) }
  scope :level_two_products, lambda { |cat_level_2| where("cat_level_2 = ?", cat_level_2.to_i) }
  scope :level_three_products, lambda { |cat_level_3| where("cat_level_3 = ?", cat_level_3.to_i) }

end
