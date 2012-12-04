class LocationsController < ApplicationController
  def index
    @locations = Location.all
  end

  def show
    @stops = Stop.location(params[:id])
    @location_name = Location.find(params[:id]).name
  end
end
