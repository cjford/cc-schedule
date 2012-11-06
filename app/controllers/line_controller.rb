class LineController < ApplicationController
  def index
    @lines = Line.all
  end

  def view
    @stops = Stop.get_line_stops(params[:id])
  end
end
