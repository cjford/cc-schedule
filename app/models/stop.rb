class Stop < ActiveRecord::Base
  belongs_to :location
  belongs_to :line
  attr_accessible :line_id, :location_id, :hour, :minute, 
                  :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday 

  default_scope order(:hour, :minute)

  def self.upcoming
    Stop.where("(hour > #{Time.now.hour} 
                OR 
                (hour = #{Time.now.hour} AND minute >= #{Time.now.min})) 
                AND 
                #{Time.now.strftime('%A')} = 't'"
              )
  end

  def self.upcoming_tomorrow
    Stop.where("(hour < #{Time.now.hour} 
                OR
                (hour = #{Time.now.hour} AND minute <= #{Time.now.min}))
                AND
                #{(Time.now+86400).strftime('%A')} = 't'"
              )
  end

  def self.location(location_id)
    if location_id.nil?
      Stop.where(:conditions => {})
    else
      Stop.where(:location_id => location_id)
    end
  end

  def self.line(line_id)
    if line_id.nil?
      Stop.where(:conditions => {})
    else
      Stop.where(:line_id => line_id)
    end
  end

  def self.upcoming_stops(num_stops, location_id, line_filter)
    upcoming = Stop.upcoming
    stops = upcoming.location(location_id).line(line_filter).limit(num_stops)

    if upcoming.length < num_stops
      extra_stops = Stop.location(location_id).upcoming_tomorrow.line(line_filter).limit(num_stops - stops.length)
      extra_stops.each do |extra_stop|
        stops << extra_stop
      end
    end
    
    return stops
  end
end
