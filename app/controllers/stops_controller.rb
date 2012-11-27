class StopsController < ApplicationController
  def index
    @locations = Location.all
    @stops = Stop.upcoming_stops_any(10)
  end
end
