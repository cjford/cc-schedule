require 'spec_helper'

describe StopsController, :type => :controller do
  describe 'GET index' do
    before :each do
      FactoryGirl.create :line, :name => 'A'
      FactoryGirl.create :line, :name => 'B'
      FactoryGirl.create :line, :name => 'C'
      FactoryGirl.create :stop, :hour => 23, :minute => 59, :monday => true, :tuesday => true, :wednesday => true, :thursday => true, :friday => true, :saturday => true, :sunday => true
    end

    it 'returns http success' do
      get 'index'
      response.should be_success
    end

    it 'renders the index view' do
      get 'index'
      response.should render_template('index')
    end

    it 'calls Stop#upcoming_stops' do
      Stop.should_receive(:upcoming_stops)
      get 'index'
    end

    it 'makes stop information available in the view' do
      fake_results = [mock('Stop1'), mock('Stop2')]
      Stop.should_receive(:upcoming_stops).and_return(fake_results)
      get 'index'
      assigns(:stops).should == fake_results
    end

    context 'when receiving post data from the filter form' do
      it 'should set the line_filter when filter data is submitted' do
        @request.env['HTTP_REFERER'] = '/'
        post 'index', {:A => true, :B => true}
        response.cookies['line_filter'].should == '12'
      end
    end

    context 'when line_filter has not yet been set' do
      it 'should set the line_filter to full' do
        request.cookies['line_filter'] = nil
        get 'index'
        response.cookies['line_filter'].should == '123'
      end
    end
  end

  describe '#refresh_upcoming' do
    it 'returns http success' do
      get 'refresh_upcoming', :location_id => 1
      response.should be_success
    end

    it 'calls Stop#upcoming_stops' do
      Stop.should_receive(:upcoming_stops)
      get 'refresh_upcoming', :location_id => 1
    end

    it 'renders the _upcoming_stops partial' do
      get 'refresh_upcoming', :location_id => 1
      response.should render_template(:partial => '_upcoming_stops')
    end

    it 'makes stop information available in the view' do
      fake_results = [mock('Stop1'), mock('Stop2')]
      Stop.should_receive(:upcoming_stops).and_return(fake_results)
      get 'refresh_upcoming', :location_id => 1
      assigns(:stops).should == fake_results
    end
  end
end
