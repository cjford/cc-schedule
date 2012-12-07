require 'spec_helper'

describe Stop do
  before :each do
    3.times {FactoryGirl.create :line}
    3.times {FactoryGirl.create :location}
    FactoryGirl.create :stop, :line_id => 1, :location_id => 1, :hour => 1, :minute => 30, :thursday => false, :friday => true
    FactoryGirl.create :stop, :line_id => 1, :location_id => 1, :hour => 13, :minute => 0, :thursday => false, :friday => true
    FactoryGirl.create :stop, :line_id => 1, :location_id => 1, :hour => 12, :minute => 0, :thursday => true, :friday => true
    FactoryGirl.create :stop, :line_id => 2, :location_id => 2, :hour => 12, :minute => 30, :thursday => true, :friday => true
    FactoryGirl.create :stop, :line_id => 3, :location_id => 3, :hour => 11, :minute => 0, :thursday => true, :friday => false
  end

  describe '#line' do
    context 'with a single line id' do
      it 'returns stops for the specified line ID' do
        stops = Stop.line(1)
        stops.first.line_id.should == 1 
        stops.where('line_id = 1').should =~ stops 
      end
    end

    context 'with all line ids' do
      it 'returns stops for all lines' do
        line_ids = []
        lines = Line.all
        lines.each { |line| line_ids << line.id }
        stops = Stop.line(line_ids)
        stops.should =~ stops.where(:conditions => {})
      end
    end

    context 'with some line ids' do
      it 'returns only stops whose line_id is in the parameter array' do
        lines = Line.all
        stops = Stop.line([lines.first, lines.second])
        stops.where(:line_id => [lines.first, lines.second]).should =~ stops
      end
    end

    context 'with no line ids' do
      it 'returns empty' do
        Stop.line([]).should be_empty
      end
    end

    context 'with nil' do
      it 'returns stops for all lines' do
        Stop.line(nil).should == Stop.where(:conditions => {})
      end
    end
  end

  describe '#location' do
    context 'with a single location id' do
      it 'returns stops for the specified location ID' do
        stops = Stop.location(1)
        stops.first.location_id.should == 1 
        stops.where('location_id = 1').should =~ stops 
      end
    end

    context 'with all location ids' do
      it 'returns stops for all locations' do
        location_ids = []
        locations = Location.all
        locations.each { |location| location_ids << location.id }
        stops = Stop.location(location_ids)
        stops.should =~ Stop.where(:conditions => {})
      end
    end

    context 'with some location ids' do
      it 'returns only stops whose location_id is in the parameter array' do
        locations = Line.all
        stops = Stop.location([locations.first, locations.second])
        stops.where(:location_id => [locations.first, locations.second]).should =~ stops
      end
    end

    context 'with no location ids' do
      it 'returns empty' do
        Stop.location([]).should be_empty
      end
    end

    context 'with nil' do
      it 'returns stops for all locations' do
        Stop.location(nil).should == Stop.where(:conditions => {})
      end
    end
  end


  describe '#upcoming' do
    it 'returns stops for the current day after the current time' do
      Time.stub(:now).and_return(Time.mktime(1970, 1, 1, 12, 00)) 
      stops = Stop.upcoming
      stops.where("#{Time.now.strftime('%A')} = 't'").should =~ stops
      stops.where("hour > #{Time.now.hour} OR (hour = #{Time.now.hour} AND minute >= #{Time.now.min})").should =~ stops 
    end
  end


  describe '#upcoming_tomorrow' do
    it 'returns stops occuring before the current time on the next day' do
      Time.stub(:now).and_return(Time.mktime(1970, 1, 1, 12, 00)) 
      stops = Stop.upcoming_tomorrow
      stops.where("#{(Time.now+86400).strftime('%A')} = 't'").should =~ stops
      stops.where("hour < #{Time.now.hour} OR (hour = #{Time.now.hour} AND minute <= #{Time.now.min})").should =~ stops 
    end
  end


  describe '#upcoming_stops' do
    before :each do
      line_ids = []
      lines = Line.all
      lines.each { |line| line_ids << line.id }
      @line_filter = line_ids
    end

    it 'calls #line' do
      Stop.should_receive(:line).at_least(1).and_return(Stop.where(:conditions => {}))
      Stop.upcoming_stops(10, nil, @line_filter)
    end

    it 'calls #location' do
      Stop.should_receive(:location).at_least(1).and_return(Stop.where(:conditions => {}))
      Stop.upcoming_stops(10, nil, @line_filter)
    end

    it 'returns no more than the specified num_stops' do
      Stop.upcoming_stops(10, nil, @line_filter).length.should <= 10
    end

    it 'calls #upcoming' do
      Stop.should_receive(:upcoming).at_least(1).and_return(Stop.where(:conditions => {}))
      Stop.upcoming_stops(10, nil, @line_filter)
    end

    context 'when there are less than the specified num_stops remaining in the current day' do
      it 'should call upcoming_tomorrow' do
        Time.stub(:now).and_return(Time.mktime(1970, 1, 1, 12, 00)) 
        Stop.should_receive(:upcoming_tomorrow).and_return(Stop.where(:conditions => {}))
        Stop.upcoming_stops(3, nil, @line_filter)
      end
    end
  end
end
