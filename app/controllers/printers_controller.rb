class PrintersController < ApplicationController
  before_action :set_groupings, only: [:index]

  def index

    @printers = Printer.all

    Rails.logger.debug "printer: #{@printers.first.inspect}"

    printer_params = params["printer"] || nil
    if printer_params != nil
        @selected_brand = printer_params["selected_brand"] || nil
        @selected_model = printer_params["selected_model"] || nil
        @selected_type = printer_params["selected_type"] || nil
    end

    @printers = @printers.scope_by_brand(@selected_brand) if @selected_brand != nil

    @printers = @printers.scope_by_model(@selected_model) if @selected_model != nil

    @printers = @printers.scope_by_type(@selected_type) if @selected_type != nil

    if @printers.count == 1
      @printer = Printer.includes([:printer_inks, :inks]).find(@printers.first.id)
    else
      @printer = nil
    end

    # Rails.logger.debug "brands: #{@brands.inspect}"
    #
    # Rails.logger.debug "ink 2: #{@printers.inks.inspect}"
    #
    # Rails.logger.debug "printer 2: #{@printers.first.inspect}"

    # if params[:page] == nil
    #   @inks = @printers.inks.order(brand: :asc, short_description: :asc).page 1
    # else
    #   @inks = @printers.inks.order(brand: :asc, short_description: :asc).page params[:page]
    # end

  end

  private

  def set_groupings
    @brands = Printer.brands
    @models = Printer.models
    @printer_types = Printer.printer_types
  end

end
