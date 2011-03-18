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
    
    it "should accept budgets that are closed to upper limit" do
      Project.new(@attr.merge(:budget => 99999999.99)).should be_valid
      lambda do
        Project.create!(@attr.merge(:budget => 99999999.99))
      end.should_not raise_error
    end
    
    it "should reject budgets that are off limit" do
      Project.new(@attr.merge(:budget => 100000000.01)).should_not be_valid
      lambda do
        Project.create!(@attr.merge(:budget => 100000000.01))
      end.should raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
