require 'spec_helper'

describe Stop do
  describe "#get_line_stops" do
    it "returns stops for the specified line ID" do
      @stop = FactoryGirl.create :stop, :line_id => 1
      stops = Stop.get_line_stops(1)
      stops.first.id.should == @stop.id
    end
  end

  describe "#get_location_stops" do
    it "returns stops for the specified location ID" do
      @stop = FactoryGirl.create :stop, :location_id => 1
      stops = Stop.get_location_stops(1)
      stops.first.id.should == @stop.id
    end
  end

end
