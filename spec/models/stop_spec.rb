require 'spec_helper'

describe Stop do
  describe "#line_stops" do
    it "returns stops for the specified line ID" do
      @stop = FactoryGirl.create :stop, :line_id => 1
      stops = Stop.line_stops(1)
      stops.first.line_id.should == @stop.line_id
    end
  end

  describe "#location_stops" do
    it "returns stops for the specified location ID" do
      @stop = FactoryGirl.create :stop, :location_id => 1
      stops = Stop.location_stops(1)
      stops.first.location_id.should == @stop.location_id
    end
  end

  describe "#upcoming_stops_any" do
    it "returns the next x stops for any location based on the current time" do
      Time.stub(:now).and_return(Time.mktime(1970, 1, 1, 12, 00)) 
      stops = Stop.upcoming_stops(1, nil)
      assert stops.length == 1 and stops.first.location_id == 8
    end
  end

  describe "#upcoming_stops" do
    it "returns the next x stops for a location based on the current time" do
      Time.stub(:now).and_return(Time.mktime(1970, 1, 1, 12, 00)) 
      stops = Stop.upcoming_stops(1, 1)
      assert stops.length == 1 and stops.first.location_id == 1
    end
  end
end
