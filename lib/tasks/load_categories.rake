desc "Load Categories"
task :load_categories => :environment do
  require 'nokogiri'
  require 'open-uri'
  require('cgi')

  def addType( level, type_name, url )
    pair = ProductCategory.new
    pair.name = type_name
    pair.level = level
    pair.url = url
    pair.save
    return [url, pair.id ]
  end

  def load_category_menu (line, first_level_id )
    baseURL = "http://www.biggestbook.com/"
    puts "load category line: #{line.inspect}"
    if line.children[0].to_s.split(/\r/).first.strip != '<img'
      level = first_level_id;
      cat2_link = baseURL + line.attributes["href"].value
      work_string = line.children[0].to_s.split(/\r/).first
      category = CGI.unescapeHTML(work_string)
      puts "tech category 2: #{category}    tech Link2: #{cat2_link}"
      return addType( level, category, cat2_link)
    end
  end

  ProductCategory.delete(:all)

  # add first level types
  firstLevelCats = []
  firstLevelCats << addType(0, "Office Supplies", "http://www.biggestbook.com/nav.jsp?N=4289220802")
  firstLevelCats << addType(0, "Technology", "http://www.biggestbook.com/nav.jsp?Ne=1900&N=4289220484")
  firstLevelCats << addType(0, "Breakroom/Janitorial", "http://www.biggestbook.com/nav.jsp?N=4289221011")
  firstLevelCats << addType(0, "Furniture", "http://www.biggestbook.com/nav.jsp?N=4289221093")

  baseURL = "http://www.biggestbook.com/"

  secondLevelCats = []

  cat_ref = firstLevelCats[0]
  puts "cat_ref1: #{cat_ref.inspect}"
  link_ref = cat_ref[0]
  first_level_id = cat_ref[1]
  count = 0
  doc = Nokogiri::HTML(open(link_ref))
  doc.css("#dropDown1 a").each do |line|
    if count > 0
      secondLevelCats << load_category_menu( line, first_level_id )
    end
    count = count + 1
  end

  cat_ref = firstLevelCats[1]
  puts "cat_ref2: #{cat_ref.inspect}"
  link_ref = cat_ref[0]
  first_level_id = cat_ref[1]
  count = 0
  doc = Nokogiri::HTML(open(link_ref))
  doc.css("#dropDown2 a").each do |line|
    if count > 0
      secondLevelCats << load_category_menu( line, first_level_id )
    end
    count = count + 1
  end

  cat_ref = firstLevelCats[2]
  link_ref = cat_ref[0]
  first_level_id = cat_ref[1]
  count = 0
  doc = Nokogiri::HTML(open(link_ref))
  doc.css("#dropDown3 a").each do |line|
    if count > 0
      secondLevelCats << load_category_menu( line, first_level_id )
    end
    count = count + 1
  end

  cat_ref = firstLevelCats[3]
  link_ref = cat_ref[0]
  first_level_id = cat_ref[1]
  count = 0
  doc = Nokogiri::HTML(open(link_ref))
  doc.css("#dropDown4 a").each do |line|
    if count > 0
      secondLevelCats << load_category_menu( line, first_level_id )
    end
    count = count + 1
  end
  sleep 3

  secondLevelCats.each do |cat_ref|
    link_ref = cat_ref[0]
    second_level_id = cat_ref[1]
    doc = Nokogiri::HTML(open(link_ref))
    doc.css("#categoryLeft a").each do |line|
      level = second_level_id
      cat2_link = baseURL + line.attributes["href"].value
      work_string = line.children[1].to_s.split(/\r/).first
      category = CGI.unescapeHTML(work_string)
      puts "category 3: #{category}    Link3: #{cat2_link}"
      addType( level, category, cat2_link)
      # puts "line: #{line.inspect}"
    end
    sleep 3
  end


  # url = baseURL + "index.faces"
  # doc = Nokogiri::HTML(open(url))
  # for i in 1..4 do
  #   css_string = '#dropDown'+i.to_s+' a'
  #   line_count = 0
  #   doc.css(css_string).each do |line|
  #
  #     if line_count > 0
  #
  #       link_ref = line.attributes["href"].value.to_s
  #       category = line.children.to_s
  #       category = CGI.unescapeHTML(category)
  #
  #       if category[0] != "<"
  #         category = category.strip
  #         prod_cat = ProductCategory.find_or_create_by(name: category )
  #         prod_cat.product_type_id = i
  #         prod_cat.url = baseURL + link_ref
  #         prod_cat.save
  #
  #         puts "category: #{category}"
  #
  #         url2 = baseURL + link_ref
  #         doc2 = Nokogiri::HTML(open(url2))
  #
  #         doc2.css("#categoryLeft a").each do |line2|
  #
  #           cat2_link = line2.attributes["href"].value
  #           work_string = line2.children[1].to_s.split(/\r/).first
  #           category = CGI.unescapeHTML(work_string)
  #           puts "category 2: #{category}"
  #           category = category.strip
  #           cat2 = ProductCategory.find_or_create_by(name: category)
  #           cat2.product_type_id = i
  #           cat2.url = baseURL + cat2_link
  #           cat2.save
  #           #puts "line2: #{line2.attributes["href"].value.inspect}"
  #           #puts "line2: #{line2.attributes["href"].value.inspect}"
  #
  #
  #           sleep 1
  #
  #           # url3 = baseURL + cat2_link
  #           # doc3 = Nokogiri::HTML(open(url3))
  #           #
  #           # doc3.css(".product").each do |line3|
  #           #
  #           #   brand = line3.css("h2").children[0].children.to_s
  #           #   link = line3.css("h2").children[0].attributes["href"].to_s
  #           #      #children[0].attributes.to_s
  #           #   #puts "line3 brand: #{brand}  link: #{link}"
  #           #
  #           #   line3.css("li").children.each do |desc_line|
  #           #     # puts "span check: #{desc_line.to_s[0..4]}"
  #           #     if desc_line.to_s[0..4] != "<span"
  #           #       #puts "desc: #{desc_line.to_s}"
  #           #     end
  #           #   end
  #
  #         end
  #
  #       end
  #
  #     end
  #     line_count = line_count + 1
  #   end
  #
  # end
end
