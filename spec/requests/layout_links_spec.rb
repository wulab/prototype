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
  end
  
  describe "when signed in" do
    
    before(:each) do
      @user = Factory(:user)
      integration_sign_in(@user)
    end
    
    it "should have a sign-out link" do
      visit root_path
      response.should have_selector("a", :href => signout_path, :content => "Sign out")
    end
    
    it "should have a profile link" do
      visit root_path
      response.should have_selector("a", :href => user_path(@user), :content => "Profile")
    end
  end
end
