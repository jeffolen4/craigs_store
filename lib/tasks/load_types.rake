require 'pry'

desc "load_types"
task :load_types => :environment do

  def addType( type_name )
    pair = ProductCategory.new
    pair.name = type_name
    pair.level = 1
    pair.save
  end

  ProductCategory.delete(:all)

  addType("Office Supplies", "http://www.biggestbook.com/nav.jsp?N=4289220802")
  addType("Technology", "http://www.biggestbook.com/nav.jsp?N=4289220484")
  addType("Breakroom/Janitorial", "http://www.biggestbook.com/nav.jsp?N=4289221011")
  addType("Furniture", "http://www.biggestbook.com/nav.jsp?N=4289221093")

end
