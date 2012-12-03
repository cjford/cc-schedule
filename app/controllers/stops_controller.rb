class StopsController < ApplicationController
  def index
    if request.post?
      cookies[:line_filter] = ''
      Line.all.each do |line|
        if !params[line.name].nil?
          cookies[:line_filter] += line.id.to_s 
        end
      end
      redirect_to request.referer
    end

    @locations = Location.order("name")
    @lines = Line.all
    @stops = Stop.upcoming_stops(10, nil, cookies[:line_filter].split(''))
  end

  def refresh
    if params[:location] == 'All'
      location = nil
    else
      location = Location.where(:name => params[:location]).first.id
    end

    @stops = Stop.upcoming_stops(10, location, cookies[:line_filter].split(''))
    render :partial => "upcoming_stops"
  end
end
