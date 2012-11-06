class Stop < ActiveRecord::Base
  belongs_to :line
  belongs_to :location
  attr_accessible :line_id, :location_id, :days, :time

  def self.get_line_stops(id)
    Stop.where(:line_id => id)
  end

  def self.get_location_stops(id)
    Stop.where(:location_id => id)
  end
end
