require 'spec_helper'

describe "LayoutLinks" do

  it "should have have a Home page at '/'" do
    get '/'
    response.should have_selector("title", :content => "Home")
  end
  
  it "should have an About page at '/about'" do
    get '/about'
    response.should have_selector("title", :content => "About")
  end
  
  it "should have a Sign-up page at '/signup'" do
    get '/signup'
    response.should have_selector("title", :content => "Sign up")
  end
  
  describe "when not signed in" do
    
    it "should have a sign-in link" do
      visit root_path
      response.should have_selector("a", :href => signin_path, :content => "Sign in")
    end
    
    it "should show company name" do
      visit root_path
      response.should have_selector("h1#logo>a", :href => root_path, :content => "Company name")
    end
    
    it "should have not have any tab menu items" do
      visit root_path
      response.should_not have_selector("div#tab")
    end
  end
  
  describe "when signed in" do
    
    before(:each) do
      @user = Factory(:user)
      integration_sign_in(@user)
      @project = Factory(:project)
    end
    
    it "should have a sign-out link" do
      visit root_path
      response.should have_selector("a", :href => signout_path, :content => "Sign out")
    end
    
    it "should have a profile link" do
      visit root_path
      response.should have_selector("a", :href => user_path(@user), :content => "Profile")
    end
    
    it "should have the right tab menu when no project selected" do
      visit root_path
      response.should have_selector("#tab a", :href => projects_path, :content => "Projects")
      response.should have_selector("#tab a", :href => users_path, :content => "People")
    end
    
    it "should have project name in the logo area when select a project" do
      visit project_path(@project)
      response.should have_selector("h1#logo", :content => @project.name)
    end
    
    it "should have the right tab menu when select a project" do
      visit project_path(@project)
      response.should have_selector("#tab a", :href => project_path(@project), :content => "Overview")
      response.should have_selector("#tab a", :href => users_project_path(@project), :content => "People")
      response.should have_selector("#tab a", :content => "Phases")
      response.should have_selector("#tab a", :content => "Tasks")
    end
  end
end
