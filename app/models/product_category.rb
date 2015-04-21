class ProductCategory < ActiveRecord::Base

  scope :level_one_cats, -> { where(level: 0) }

  scope :level_two_cats, lambda { |level| where("level = ?", level.to_i ) }

  scope :level_three_cats, lambda { |level| where("level = ?", level.to_i ) }

  def to_hash
    hash = {}; self.attributes.each { |k,v| hash[k] = v }
    return hash
  end

end
