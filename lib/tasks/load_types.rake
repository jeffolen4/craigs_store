desc "load_types"
task :load_types => :environment do

  def addType( type_name )
    pair = ProductType.new
    pair.name = type_name
    pair.save
  end

  addType("Office Supplies")
  addType("Technology")
  addType("Breakroom/Janitorial")
  addType("Furniture")

end
