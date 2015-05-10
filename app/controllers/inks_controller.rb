class InksController < ApplicationController


  def show
    @ink = Ink.find(params["id"])
    @brand = params["brand"]
    @model = params["model"]
    @lines = @ink.long_description.split("\n")
  end

end
