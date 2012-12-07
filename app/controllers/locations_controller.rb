class LocationsController < ApplicationController
  def index
    @locations = Location.all
  end

  def show
    @stops = Stop.where("#{Time.now.strftime('%A')}" => 't').line(cookies[:line_filter].split('')).location(params[:id])
    @location_name = Location.find(params[:id]).name
    @location_id = params[:id]
  end

  def refresh_location
    @stops = Stop.location(params[:location_id]).line(cookies[:line_filter].split('')).where(params[:day] => 't')
    render :partial => 'location_stops'
  end
end
