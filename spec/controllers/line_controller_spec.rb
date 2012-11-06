require 'spec_helper'

describe LineController, :type => :controller do
  describe "GET 'index'" do

    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it "renders the 'index' view" do
      get 'index'
      response.should render_template('index')
    end

    it "makes line information available in the index view" do
      get 'index'
      assigns(:lines).should == Line.all 
    end
  end

  describe "GET 'view'" do

    it "returns http success" do
      get 'view', :id => 1
      response.should be_success
    end

    it "calls the Stop model method to get stops for the specified line" do
      Stop.stub :get_line_stops
      Stop.should_receive :get_line_stops
      get 'view', :id => 1
    end

    it "renders the 'view' view" do
      get 'view', :id => 1
      response.should render_template(:view)
    end

    it "makes line information available in the view" do
      fake_results = [mock('Stop1'), mock('Stop2')]
      Stop.stub :get_line_stops
      Stop.should_receive(:get_line_stops).and_return(fake_results)
      get 'view', :id => 1
      assigns(:stops).should == fake_results
    end

  end
end
