class Ink < ActiveRecord::Base
  has_many :printer_inks
  has_many :printers, through: :printer_inks
end
