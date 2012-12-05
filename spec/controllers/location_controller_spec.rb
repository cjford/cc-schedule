require 'spec_helper'

describe LocationsController do
  before :each do 
    @request.cookies['line_filter'] = '12345'
    FactoryGirl.create :location
  end

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
      assigns(:locations).should =~ Location.where(:conditions => {})
    end
  end


  describe "GET 'show'" do
    it "returns http success" do
      get 'show', :id => 1
      response.should be_success
    end

    it "renders the 'show' view" do
      get 'show', :id => 1
      response.should render_template(:show)
    end

    it "calls the Stop model method to get stops for the specified location" do
      Stop.should_receive :location
      get 'show', :id => 1
    end

    it "makes location information available in the view" do
      fake_results = [mock('Stop1'), mock('Stop2')]
      Stop.should_receive(:location).and_return(fake_results)
      get 'show', :id => 1
      assigns(:stops).should == fake_results
    end
  end
end
