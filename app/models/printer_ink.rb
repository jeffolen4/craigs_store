class PrinterInk < ActiveRecord::Base
  belongs_to :printer
  belongs_to :ink
end
