class Printer < ActiveRecord::Base
  has_many :printer_inks
  has_many :inks, through: :printer_inks
end
