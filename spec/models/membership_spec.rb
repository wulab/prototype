require 'spec_helper'

describe Membership do
  
  before(:each) do
    @user = Factory(:user)
    @project = Factory(:project)
    
    @membership = @project.memberships.build(:user_id => @user)
  end
  
  it "should create a new instace given valid attributes" do
    @membership.save!
  end
  
  describe "user/project methods" do
    
    before(:each) do
      @membership.save
    end
    
    it "should have a user attribute" do
      @membership.should respond_to(:user)
    end
    
    it "should have the right user" do
      @membership.user.should == @user
    end
    
    it "should have a project attribute" do
      @membership.should respond_to(:project)
    end
    
    it "should have the right project" do
      @membership.project.should == @project
    end
  end
  
  describe "validations" do
    
    it "should require a project_id" do
      @membership.project = nil
      @membership.should_not be_valid
    end
    
    it "should require a user_id" do
      @membership.user = nil
      @membership.should_not be_valid
    end
  end
end
