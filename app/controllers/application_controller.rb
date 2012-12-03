class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_filter
  
  def set_filter
    if cookies[:line_filter].nil?
      cookies[:line_filter] = ''
      Line.all.each do |line|
        cookies[:line_filter] += line.id.to_s
      end
    end
  end

end
