class Stop < ActiveRecord::Base
  belongs_to :line
  belongs_to :location
  attr_accessible :line_id, :location_id, :hour, :minute, 
                  :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday 

  def self.line_stops(id)
    Stop.where(:line_id => id)
  end

  def self.location_stops(id)
    Stop.where(:location_id => id)
  end

  def self.upcoming_stops(num_stops, location)
    if location.nil?
      Stop.find(:all, {
                  :conditions => ["hour >= ? AND minute >= ? AND #{Time.now.strftime("%A")} = 't'", 
                    Time.now.hour, Time.now.min], 
                  :order => "hour, minute", 
                  :limit => num_stops
                })
    else
      Stop.find(:all, {
                  :conditions => ["hour >= ? AND minute >= ? AND location_id = ? AND #{Time.now.strftime("%A")} = 't'", 
                    Time.now.hour, Time.now.min, location], 
                  :order => "hour, minute", 
                  :limit => num_stops
                })
    end
  end
end
