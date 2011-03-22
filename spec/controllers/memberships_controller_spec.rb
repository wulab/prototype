require 'spec_helper'

describe MembershipsController do
  
  describe "access control" do
    
    it "should require sign in for create" do
      post :create
      response.should redirect_to(signin_path)
    end
    
    it "should require sign in for destroy" do
      delete :destroy, :id => 1
      response.should redirect_to(signin_path)
    end
    
    describe "when signed in" do
      
      before(:each) do
        @user = test_sign_in(Factory(:user))
      end
      
      it "should require an admin for create" do
        post :create
        response.should redirect_to(root_path)
      end
      
      it "should require an admin for destroy" do
        delete :destroy, :id => 1
        response.should redirect_to(root_path)
      end
    end
  end
  
  describe "POST 'create'" do
    
    before(:each) do
      @admin = test_sign_in(Factory(:user, :admin => true))
      @user = Factory(:user, :email => Factory.next(:email))
      @project = Factory(:project)
    end
    
    it "should create a membership" do
      lambda do
        post :create, :membership => {:project_id => @project, :user_id => @user}
        response.should be_redirect
      end.should change(Membership, :count).by(1)
    end
  end
  
  describe "DELETE 'destroy'" do
    
    before(:each) do
      @admin = test_sign_in(Factory(:user, :admin => true))
      @user = Factory(:user, :email => Factory.next(:email))
      @project = Factory(:project)
      @project.add_user!(@user)
      @membership = @user.memberships.find_by_user_id(@user)
    end
    
    it "should destroy a membership" do
      lambda do
        delete :destroy, :id => @membership
        response.should be_redirect
      end.should change(Membership, :count).by(-1)
    end
  end
end
