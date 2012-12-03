class LocationsController < ApplicationController
  def index
    @locations = Location.all
  end

  def show
    @stops = Stop.location_stops(params[:id], cookies[:line_filter].split(''))
    @location_name = Location.find(params[:id]).name
  end
end
