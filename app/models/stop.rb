class Stop < ActiveRecord::Base
  #belongs_to :line
  #belongs_to :location
  attr_accessible :line_id, :location_id, :hour, :minute, 
                  :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday 


  default_scope order(:hour, :minute)

  scope :line_filter, lambda { |line_filter| where(:line_id => line_filter) }
  
  scope :upcoming, :conditions => ["hour > #{Time.now.hour} 
                                    OR 
                                    (hour = #{Time.now.hour} AND minute >= #{Time.now.min}) 
                                    AND 
                                    #{Time.now.strftime('%A')} = 't'"]

  scope :upcoming_tomorrow, :conditions => ["hour < #{Time.now.hour} 
                                             AND 
                                             #{(Time.now+86400).strftime('%A')} = 't'"]

  scope :location, (lambda do |location| 
    if !location.nil?
      where(:location_id => location) 
    else
      {:conditions => {}}
    end
  end)

  def self.line_stops(id)
    Stop.where(:line_id => id)
  end

  def self.location_stops(id, line_filter)
    Stop.where(:location_id => id, :line_id => line_filter)
  end

  def self.upcoming_stops(num_stops, location, line_filter)
  
    stops = Stop.location(location).upcoming.line_filter(line_filter).limit(num_stops)

    if stops.length < num_stops
      extra_stops = Stop.location(location).upcoming_tomorrow.limit(num_stops - stops.length)
      extra_stops.each do |extra_stop|
        stops << extra_stop
      end
    end
    
    return stops

  end
end
