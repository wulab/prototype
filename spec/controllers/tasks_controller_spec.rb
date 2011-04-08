require 'spec_helper'

describe TasksController do
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      get 'new', :project_id => Factory(:project)
      response.should be_success
    end
  end

  describe "POST 'create'" do
    it "should be successful" do
      post 'create', :project_id => Factory(:project), :task => {}
      response.should be_success
    end
  end

end
