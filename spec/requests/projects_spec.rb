require 'spec_helper'

describe "Projects" do
  
  before(:each) do
    @user = Factory(:user)
    integration_sign_in(@user)
  end
  
  describe "creation" do
    
    describe "failure" do
      
      it "should not make a new project" do
        lambda do
          visit projects_path
          click_link "create_project"
          fill_in :project_name, :with => ""
          fill_in :project_description, :with => ""
          fill_in :project_budget, :with => ""
          click_button
          response.should render_template('projects/new')
          response.should have_selector("p.inline-errors")
        end.should_not change(Project, :count)
      end
    end # describe 'failure'
    
    describe "success" do
      
      it "should make a new project" do
        lambda do
          visit projects_path
          click_link "create_project"
          fill_in :project_name, :with => "lorem ipsum"
          fill_in :project_description, :with => "lorem ipsum dolor sit amet"
          fill_in :project_budget, :with => 99.99
          click_button
          response.should have_selector("div.alert", :content => "created")
          response.should render_template('projects/show')
        end.should change(Project, :count).by(1)
      end
    end # describe 'success'
  end # describe 'creation'
end # describe 'Projects'
