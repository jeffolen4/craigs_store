desc "Load Categories"
task :load_categories => :environment do
  require 'nokogiri'
  require 'open-uri'
  require('cgi')

  url = "http://www.biggestbook.com/index.faces"
  doc = Nokogiri::HTML(open(url))
  for i in 1..1 do
    css_string = '#dropDown'+i.to_s+' a'
    doc.css(css_string).each do |line|

      link_ref = line.attributes["href"].value.to_s
      category = line.children.to_s
      category = CGI.unescapeHTML(category)

      if category[0] != "<"
        cat = ProductCategory.find_or_create_by(name: category )
        cat.product_type_id = i
        cat.save
      end

      sleep 5
      url2 = "http://www.biggestbook.com/" + link_ref
      doc2 = Nokogiri::HTML(open(url2))

      doc2.css("#categoryLeft a").each do |line2|

        puts "line2: #{line2.children.attributes.inspect}"
      end

      # url= "http://www.biggestbook.com/nav.jsp?N=4289220801"

      # begin
      #   category = line.children.to_s
      #   if category[0] != "<"
      #     puts "line children: #{CGI.unescapeHTML(category)}"
      #     pair = ProductCategory.new
      #     pair.product_type_id = i
      #     pair.name = CGI.unescapeHTML(category)
      #     pair.save
      #   end
      # rescue
      #   puts "failed line: #{line.children}"
      # end
    end

  end
end
