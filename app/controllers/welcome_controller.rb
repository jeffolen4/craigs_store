class WelcomeController < ApplicationController
  before_action :set_product_category, only: [:show, :edit, :update, :destroy]

  # GET /product_categories
  # GET /product_categories.json
  def index

    @cat_first = ProductCategory.level_one_cats

    @selected_cat_one = ""
    @selected_cat_two = ""
    @selected_cat_three = ""
    @selected_cat_one_name = ""
    @selected_cat_two_name = ""
    @selected_cat_three_name = ""
    @cat_second = nil
    @cat_third = nil
    
    @products = Product.all

    cat_params = params["category"]

    if cat_params != nil
      if cat_params["selected_cat_one"] != nil && cat_params["selected_cat_one"] != ""
        @selected_cat_one = cat_params["selected_cat_one"]
        @products = @products.level_one_products(@selected_cat_one)
        @cat_second = ProductCategory.level_two_cats(@selected_cat_one)
        @select_cat_one_name = ProductCategory.where( "id = ?", @selected_cat_one.to_i).first.name
        logger.debug "selected cat one name: #{@select_cat_one_name}     second level categories: #{@cat_second.inspect}"
      end
      if cat_params["selected_cat_two"] != nil && cat_params["selected_cat_two"] != ""
        @selected_cat_two = cat_params["selected_cat_two"]
        @products = @products.level_two_products(@selected_cat_two)
        @cat_third = ProductCategory.level_three_cats(@selected_cat_two)
        @select_cat_two_name = ProductCategory.where( "id = ?", @selected_cat_two.to_i).first.name
        logger.debug "third level categories: #{@cat_third.inspect}"
      end
      if cat_params["selected_cat_three"] != nil && cat_params["selected_cat_three"] != ""
        @selected_cat_three = cat_params["selected_cat_three"]
        @products = @products.level_three_products(@selected_cat_three)
        @select_cat_three_name = ProductCategory.where( "id = ?", @selected_cat_three.to_i).first.name
        logger.debug "third level categories: #{@cat_third.inspect}"
      end
    end
  end

end
