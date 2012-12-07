require 'spec_helper'

describe LocationsController do
  before :each do 
    FactoryGirl.create :location
    FactoryGirl.create :stop, :location_id => 1, :monday => true
  end

  describe 'GET index' do
    it 'returns http success' do
      get 'index'
      response.should be_success
    end

    it 'renders the index view' do
      get 'index'
      response.should render_template('index')
    end

    it 'makes location information available in the view' do
      get 'index'
      assigns(:locations).should =~ Location.where(:conditions => {})
    end
  end


  describe 'GET show' do
    it 'returns http success' do
      get 'show', :id => 1
      response.should be_success
    end

    it 'renders the show view' do
      get 'show', :id => 1
      response.should render_template(:show)
    end

    it 'calls Stop#location' do
      Stop.should_receive :location
      get 'show', :id => 1
    end

    it 'makes location information available in the view' do
      fake_results = [mock('Stop1'), mock('Stop2')]
      Stop.should_receive(:location).and_return(fake_results)
      get 'show', :id => 1
      assigns(:stops).should == fake_results
    end
  end

  describe '#refresh_location' do
    it 'returns http success' do
      get 'refresh_location', :location_id => 1, :day => 'Monday'
      response.should be_success
    end

    it 'calls Stop#location' do
      Stop.should_receive(:location).and_return(Stop.where(:conditions => {}))
      get 'refresh_location', :location_id => 1, :day => 'Monday'
    end

    it 'renders the _location_stops partial' do
      get 'refresh_location', :location_id => 1, :day => 'Monday'
      response.should render_template(:partial => '_location_stops')
    end
  end

end
