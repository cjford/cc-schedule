class LocationController < ApplicationController
  def index
    @locations = Location.all
  end

  def view
    @stops = Stop.get_location_stops(params[:id])
  end
end
