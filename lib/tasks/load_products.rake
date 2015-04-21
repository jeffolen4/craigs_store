desc "Load Products"
task :load_products => :environment do
  require 'nokogiri'
  require 'open-uri'
  require('cgi')

  def getCategoryChain (start_cat)
    cat_array = []
    cat_array.unshift(start_cat)
    3.times do
      cat_work = ProductCategory.where("id = ?", start_cat.to_i).first
      # puts "cat_work: #{cat_work.inspect}"
      if cat_work != nil
        start_cat = cat_work.level
        cat_array.unshift(start_cat) unless start_cat.to_i == 0
      else
        start_cat = 0
      end
      break if start_cat == 0
    end
    return cat_array
  end

  def addType( level, type_name, url )
    pair = ProductCategory.new
    pair.name = type_name
    pair.level = level
    pair.url = url
    pair.save
    return [url, pair.id ]
  end

  categories = ProductCategory.all

  categories.each do |category|
    doc = Nokogiri::HTML(open(category.url))
    doc.css(".product").each do |line|
      # puts "category level: #{category.level.inspect}"
      break unless category.level > 0
      check_cat = ProductCategory.where("level = ?", category.id.to_i)
      puts "check cat: #{check_cat.inspect}"
      break unless check_cat.count == 0
      category_ids = getCategoryChain(category.id)
      puts "category chain: #{category_ids.inspect}"

      brand = line.css("h2").children[0].children[0].to_s
      image_url = line.css("img").first['src']
      detail_url = line.css("h2").children[0].attributes["href"].to_s
      short_desc = line.css(".shortdesc").children[0].children[0].to_s
      price = line.css(".price").text.to_s[1..-1]  #.children[0].to_s
      price_unit = price.split("/")
      puts "brand: #{brand}  price: #{price_unit[0]}  unit: #{price_unit[1]}"
      product = Product.new
      product.cat_level_1 = category_ids[0]
      product.cat_level_2 = category_ids[1]
      product.cat_level_3 = category_ids[2] unless category_ids[2] == nil
      product.name = short_desc
      product.brand = brand
      product.url = detail_url
      product.image_url = image_url
      product.price = price_unit[0].to_d
      product.unit = price_unit[1].to_s
      product.save
      # count = 0
      # price.attributes.each do |key, children|
      #   puts "child #{key}: #{children.inspect}"
      #   count = count + 1
      # end
      # puts "line: #{line.inspect}"
      # puts "brand: #{brand.inspect}    url: #{detail_url.inspect}"
      # puts "category: #{category.inspect}"
    end
    puts "added products"
    sleep 1
  end
  sleep 30
end
