require 'spec_helper'

describe StopsController, :type => :controller do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
    it "renders the 'index' view" do
      get 'index'
      response.should render_template('index')
    end
    it "calls the Stop model method to get next 10 stops" do
      Stop.should_receive(:upcoming_stops).with(10, nil)
      get 'index'
    end
    it "makes stop information available in the index view" do
      fake_results = [mock('Stop1'), mock('Stop2')]
      Stop.stub :upcoming_stops
      Stop.should_receive(:upcoming_stops).and_return(fake_results)
      get 'index'
      assigns(:stops).should == fake_results
    end
  end

end
