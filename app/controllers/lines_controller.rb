class LinesController < ApplicationController
  def index
    @lines = Line.all
  end

  def show
    @stops = Stop.where("#{Time.now.strftime('%A').downcase}" => 't').line(params[:id])
    @line_name = Line.find(params[:id]).name
    @line_id = params[:id]
  end

  def refresh_line
    @stops = Stop.line(params[:line_id]).where(params[:day].downcase => 't')
    render :partial => 'line_stops'
  end
end
