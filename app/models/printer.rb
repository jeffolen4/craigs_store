class Printer < ActiveRecord::Base
  has_many :printer_inks
  has_many :inks, through: :printer_inks

  paginates_per 20

  scope :scope_by_brand, lambda { |brand| where("brand = ?", brand ) }
  scope :scope_by_model, lambda { |model| where("model = ?", model) }
  scope :scope_by_type, lambda { |printer_type| where("printer_type = ?",
    printer_type) }

  def self.models
    select('model').group('model').order('model ASC')
  end

  def self.brands
    select('brand').group('brand').order('brand ASC')
  end

  def self.printer_types
    select('printer_type').group('printer_type').order('printer_type ASC')
  end

end
