require 'spec_helper'

describe LocationController do
  describe "GET 'index'" do

    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it "renders the 'index' view" do
      get 'index'
      response.should render_template('index')
    end

    it "makes location information available in the index view" do
      get 'index'
      assigns(:locations).should == Location.all
    end
  end


  describe "GET 'view'" do

    it "returns http success" do
      get 'view', :id => 1
      response.should be_success
    end

    it "renders the 'view' view" do
      get 'view', :id => 1
      response.should render_template(:view)
    end

    it "calls the Stop model method to get stops for the specified location" do
      Stop.stub :get_location_stops
      Stop.should_receive :get_location_stops
      get 'view', :id => 1
    end

    it "makes location information available in the view" do
      fake_results = [mock('Stop1'), mock('Stop2')]
      Stop.stub :get_location_stops
      Stop.should_receive(:get_location_stops).and_return(fake_results)
      get 'view', :id => 1
      assigns(:stops).should == fake_results
    end

  end
end
