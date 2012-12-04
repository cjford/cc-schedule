class LinesController < ApplicationController
  def index
    @lines = Line.all
  end

  def show
    @stops = Stop.line(params[:id])
    @line_name = Line.find(params[:id]).name
  end
end
