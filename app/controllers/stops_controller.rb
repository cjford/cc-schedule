class StopsController < ApplicationController
  def index
    @locations = Location.all
    @stops = Stop.upcoming_stops(10, nil)
  end
end
