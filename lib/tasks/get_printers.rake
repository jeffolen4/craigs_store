desc "Get_Printers"
task :get_printers => :environment do
  require 'nokogiri'
  require 'open-uri'
  require('cgi')

  url = "http://www.biggestbook.com/"

  def parseBrandString (brand)

    # get brand
    brand_start = brand.index("Brand:") + 6
    brand_end = brand.index("<br>", brand_start)
    brand_name = brand[brand_start, brand_end-brand_start]

    # get device type
    device_start = brand.index("Device:") + 7
    device_end = brand.index("<br>", device_start)
    device_type = brand[device_start, device_end-device_start]

    # get model
    model_start = brand.index("Model:") + 6
    model_end = brand.index("<br>", model_start)
    model_type = brand[model_start, model_end-model_start]

    return brand_name.strip, device_type.strip, model_type.strip
  end

  doc = Nokogiri::HTML(open("http://www.biggestbook.com/PrinterSupplyFinder.jsp"))
  doc.css("#inktonerleftside a").each do |line|

    # puts "line #{line["href"]}"
    if line["href"].match('brand')

      doc2 = Nokogiri::HTML(open(url + line["href"]))
      doc2.css(".linkcolumn a").each do |link|
        # puts("link: #{url+link["href"]}")
        model_start = link.to_s.index("</span>")+7
        model_end = link.to_s.index("</a>", model_start)
        model_string = link.to_s[model_start, model_end-model_start].strip

        chk = Printer.where("model = ?", model_string)
        if chk.count == 0

          doc4 = Nokogiri::HTML(open(url + link["href"]))
            #sleep 5
          printer_info = doc4.css("#selected")
          brand_start = printer_info.to_s.index("br>")
          brand_end = printer_info.to_s.index("</div>", brand_start+3)
          brand_string = printer_info.to_s[brand_start, brand_end-brand_start]
          brand, type, model = parseBrandString(brand_string)

          puts "brand: #{brand}  type: #{type}  model: #{model}"
          chk = Printer.where("brand = ? and printer_type = ? and model = ?", brand, type, model)
          if chk.count == 0
            p = Printer.new
            p.brand = brand
            p.printer_type =  type
            p.model =  model
            p.save
          else
            puts "printer already exists."
            p = chk[0]
            if p.id < 645
              sleep 2
              next
            end
          end

          begin

            doc4.css(".product").each do |line|
              image_url = line.css("img").first['src']
              detail_url = line.css("h2").children[0].attributes["href"].to_s
              short_desc = line.css(".shortdesc").children[0].children[0].to_s
              desc_long = ""
              doc4.css("#productsArea li").children.each do |desc_line|
                desc_line = desc_line.to_s
                if desc_line.length > 2 && desc_line.match("</span>") == nil
                  # puts "desc_line: #{desc_line}"
                  desc_long.concat(desc_line.strip + "\n")
                end
              end
              desc_long.strip!
              price = line.css(".price").text.to_s[1..-1]  #.children[0].to_s
              price_unit = price.split("/")
              #puts "line string: #{line.to_s}"
              sku_work_start = line.to_s.index('class="price"')
              sku_work = line.to_s[sku_work_start..-1]
              sku_start = sku_work.index("/b>")+3
              sku_end = sku_work.index("/div>",sku_start)
              sku = sku_work[sku_start, sku_end - (sku_start+1)].strip
              puts "sku: #{sku}"
              # puts "price work area: #{sku_work}"
              # puts "brand: #{brand}  price: #{price_unit[0]}  unit: #{price_unit[1]}"
              # puts "image link: #{image_url}"
              # puts "long desc: #{desc_long}"
              chk = Ink.where("image_url = ?", image_url)
              if chk.count == 0
                i = Ink.new
                i.brand = brand
                i.price = price_unit[0]
                i.unit = price_unit[1]
                i.image_url = image_url
                i.short_description = short_desc
                i.long_description = desc_long
                i.sku = sku
                i.save
              else
                puts "ink already exists"
                i = chk[0]
              end

              chk = PrinterInk.where("printer_id = ? and ink_id = ?", p.id, i.id )
              if chk == []
                li = PrinterInk.new
                li.printer_id = p.id
                li.ink_id = i.id
                li.save
              end

            end
            sleep 2
            next_page = doc4.css("#content a+ a")
            # puts "next page: #{next_page[0]["href"]}"
            if next_page.to_s.length != 0 && next_page.to_s.match("Next") != nil
              puts "next page: #{next_page[-1]["href"]}"
              doc4 = Nokogiri::HTML(open(url + next_page[-1]["href"]))
            else
              next_page = nil
            end
          end while next_page != nil

          sleep 5
        end
      end

      sleep 5
    end

  end
end
