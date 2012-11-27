class LocationsController < ApplicationController
  def index
    @locations = Location.all
  end

  def show
    @stops = Stop.location_stops(params[:id])
  end
end
