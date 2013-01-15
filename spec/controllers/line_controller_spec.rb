require 'spec_helper'

describe LinesController, :type => :controller do
  before :each do
    FactoryGirl.create :line
    FactoryGirl.create :stop, :line_id => 1, :monday => true
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

    it 'makes line information available in the view' do
      get 'index'
      assigns(:lines).should =~ Line.scoped 
    end
  end


  describe 'GET show' do
    it 'returns http success' do
      get 'show', :id => 1
      response.should be_success
    end

    it 'calls Stop#line' do
      Stop.should_receive(:line)
      get 'show', :id => 1
    end

    it 'renders the show view' do
      get 'show', :id => 1
      response.should render_template(:show)
    end

    it 'makes line information available in the view' do
      fake_results = [mock('Stop1'), mock('Stop2')]
      Stop.should_receive(:line).and_return(fake_results)
      get 'show', :id => 1
      assigns(:stops).should == fake_results
    end
  end

  describe '#refresh_line' do
    it 'returns http success' do
      get 'refresh_line', :line_id => 1, :day => 'Monday'
      response.should be_success
    end

    it 'calls Stop#line' do
      Stop.should_receive(:line).and_return(Stop.scoped)
      get 'refresh_line', :line_id => 1, :day => 'Monday'
    end

    it 'renders the _line_stops partial' do
      get 'refresh_line', :line_id => 1, :day => 'Monday'
      response.should render_template(:partial => '_line_stops')
    end
  end
end
