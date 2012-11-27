class LinesController < ApplicationController
  def index
    @lines = Line.all
  end

  def show
    @stops = Stop.line_stops(params[:id])
  end
end
