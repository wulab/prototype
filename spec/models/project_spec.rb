require 'spec_helper'

describe Project do
  
  before(:each) do
    @attr = {
      :name => "exercitationem aut",
      :description => "laboriosam enim est quia",
      :budget => 99.99
    }
  end
  
  it "should create a new instance given valid attribute" do
    Project.create!(@attr)
  end
  
  describe "validations" do
    
    it "should require a name" do
      Project.new(@attr.merge(:name => "")).should_not be_valid
    end
    
    it "should require a budget" do
      Project.new(@attr.merge(:budget => nil)).should_not be_valid
    end
    
    it "should reject names that are too long" do
      long_name = "a" * 101
      User.new(@attr.merge(:name => long_name)).should_not be_valid
    end
    
    it "should reject duplicate names" do
      Project.create!(@attr)
      Project.new(@attr.merge(:description => "pariatur rem nisi perspiciatis")).should_not be_valid
    end
    
    it "should reject negative budget" do
      Project.new(@attr.merge(:budget => -99.99)).should_not be_valid
    end
    
    it "should reject non-numerical budget" do
      Project.new(@attr.merge(:budget => "xx.xx")).should_not be_valid
    end
  end
  
  describe "memberships" do
    
    before(:each) do
      @project = Project.create!(@attr)
      @user = Factory(:user)
    end
    
    it "should have a memberships method" do
      @project.should respond_to(:memberships)
    end
    
    it "should have a users method" do
      @project.should respond_to(:users)
    end
    
    it "should have a has_user? method" do
      @project.should respond_to(:has_user?)
    end
    
    it "should have an add_user! method" do
      @project.should respond_to(:add_user!)
    end
    
    it "should have a user" do
      @project.add_user!(@user)
      @project.has_user?(@user).should be_true
    end
    
    it "should include the added user in the users array" do
      @project.add_user!(@user)
      @project.users.should include(@user)
    end
    
    it "should raise error when adding the same user twice" do
      @project.add_user!(@user)
      lambda do
        @project.add_user!(@user)
      end.should raise_error(ActiveRecord::RecordNotUnique)
    end
    
    it "should not raise error when adding different users" do
      @user2 = Factory(:user, :email => Factory.next(:email))
      @project.add_user!(@user)
      lambda do
        @project.add_user!(@user2)
      end.should_not raise_error(ActiveRecord::RecordNotUnique)
    end
    
    it "should have an remove_user! method" do
      @project.should respond_to(:remove_user!)
    end
    
    it "should remove a user" do
      @project.add_user!(@user)
      @project.remove_user!(@user)
      @project.has_user?(@user).should be_false
    end
  end
end
