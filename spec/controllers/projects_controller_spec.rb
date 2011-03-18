require 'spec_helper'

describe ProjectsController do
  render_views
  
  describe "for non-signed-in users" do
    
    it "should deny all accesses" do
      @project = Factory(:project)
      get :index
      response.should redirect_to(signin_path)
      get :show, :id => @project
      response.should redirect_to(signin_path)
      get :new, :id => @project
      response.should redirect_to(signin_path)
      get :edit, :id => @project
      response.should redirect_to(signin_path)
      post :create, :project => { }
      response.should redirect_to(signin_path)
      put :update, :id => @project, :project => { }
      response.should redirect_to(signin_path)
      delete :destroy, :id => @project
      response.should redirect_to(signin_path)
    end
  end
  
  describe "for signed-in users" do
    
    before(:each) do
      @user = test_sign_in(Factory(:user))
    end
    
    describe "GET 'index'" do
      
      before(:each) do
        @projects = []
        30.times do
          @projects << Factory(:project, :name => Factory.next(:project_name))
        end
      end
    
      it "should be successful" do
        get :index
        response.should be_success
      end
      
      it "should have the right title" do
        get :index
        response.should have_selector("title", :content => "Company projects")
      end
      
      it "should have an element for each project" do
        get :index
        @projects[0..2].each do |project|
          response.should have_selector("a", :href => project_path(project), :content => project.name)
        end
      end
    end
    
    describe "GET 'new'" do
    
      it "should be successful" do
        get :new
        response.should be_success
      end
      
      it "should have the right title" do
        get :new
        response.should have_selector("title", :content => "Create project")
      end
      
      it "should have all required fields" do
        get :new
        response.should have_selector("input[name='project[name]'][type='text']")
        response.should have_selector("textarea[name='project[description]']")
        response.should have_selector("input[name='project[budget]'][type='text']")
      end
    end
    
    describe "GET 'show'" do
      
      before(:each) do
        @project = Factory(:project)
      end
      
      it "should be successful" do
        get :show, :id => @project
        response.should be_success
      end
      
      it "should find the right project" do
        get :show, :id => @project
        assigns(:project).should == @project
      end
      
      it "should have the right title" do
        get :show, :id => @project
        response.should have_selector("title", :content => "Project overview")
      end
      
      it "should include project indicators" do
        get :show, :id => @project
        response.should have_selector("ul.panel")
      end
      
      it "should not have a projects link" do
        get :show, :id => @project
        response.should_not have_selector("#tab a", :href => projects_path, :content => "Projects")
      end
      
      it "should not have any edit project links" do
        get :show, :id => @project
        response.should_not have_selector("a", :href => edit_project_path(@project))
      end
      
      it "should not have any delete project links" do
        get :show, :id => @project
        response.should_not have_selector("a[data-method='delete']", :href => project_path(@project))
      end
    end
    
    describe "POST 'create'" do
      
      describe "failure" do
        
        before(:each) do
          @attr = {:name => "", :description => "", :budget => nil}
        end
        
        it "should not create a project" do
          lambda do
            post :create, :project => @attr
          end.should_not change(Project, :count)
        end
        
        it "should have the right title" do
          post :create, :project => @attr
          response.should have_selector("title", :content => "Create project")
        end
        
        it "should render the 'new' page" do
          post :create, :project => @attr
          response.should render_template('new')
        end
      end
      
      describe "success" do
        
        before(:each) do
          @attr = {
            :name => "lorem ipsum",
            :description => "lorem ipsum dolor sit amet",
            :budget => 99.99
          }
        end
        
        it "should create a project" do
          lambda do
            post :create, :project => @attr
          end.should change(Project, :count).by(1)
        end
        
        it "should redirect to the project show page" do
          post :create, :project => @attr
          response.should redirect_to(project_path(assigns(:project)))
        end
      end
    end
    
    describe "GET 'edit'" do
      
      before(:each) do
        @project = Factory(:project)
      end
      
      it "should be successful" do
        get :edit, :id => @project
        response.should be_success
      end
      
      it "should have the right title" do
        get :edit, :id => @project
        response.should have_selector("title", :content => "Edit project")
      end
    end
    
    describe "PUT 'update'" do
      
      before(:each) do
        @project = Factory(:project)
      end
      
      describe "failure" do
        
        before(:each) do
          @attr = {:name => "", :description => "", :budget => ""}
        end
        
        it "should render the 'edit' page" do
          put :update, :id => @project, :project => @attr
          response.should render_template('edit')
        end
        
        it "should have the right title" do
          put :update, :id => @project, :project => @attr
          response.should have_selector("title", :content => "Edit project")
        end
      end
      
      describe "success" do
        
        before(:each) do
          @attr = {
            :name => "lorem ipsum",
            :description => "lorem ipsum dolor sit amet",
            :budget => 99.99
          }
        end
        
        it "should change the project attributes" do
          put :update, :id => @project, :project => @attr
          @project.reload
          @project.name.should == @attr[:name]
          @project.description.should == @attr[:description]
          @project.budget.should == @attr[:budget]
        end
        
        it "should redirect to project 'show' page" do
          put :update, :id => @project, :project => @attr
          response.should redirect_to(project_path(@project))
        end
      end # describe 'success'
    end # describe 'PUT update'
    
    describe "DELETE 'destroy'" do
      
      before(:each) do
        @project = Factory(:project)
      end
      
      it "should not destroy project" do
        lambda do
          delete :destroy, :id => @project
        end.should_not change(Project, :count)
      end
      
      it "should protect the page" do
        delete :destroy, :id => @project
        response.should redirect_to(root_path)
      end
    end # describe 'DELETE destroy'
  end # describe 'for signed-in users'
  
  describe "for admin users" do
  
    before(:each) do
      @admin = Factory(:user, :email => "admin@example.com", :admin => true)
      test_sign_in(@admin)
      @project = Factory(:project)
    end
    
    describe "GET 'show'" do
      
      it "should have edit project link" do
        get :show, :id => @project
        response.should have_selector("a", :href => edit_project_path(@project))
      end
      
      it "should have delete project link" do
        get :show, :id => @project
        response.should have_selector("a[data-method='delete']", :href => project_path(@project))
      end
    end
    
    describe "DELETE 'destroy'" do
    
      it "should destroy project" do
        lambda do
          delete :destroy, :id => @project
        end.should change(Project, :count).by(-1)
      end
      
      it "should redirect to projects page" do
        delete :destroy, :id => @project
        response.should redirect_to(projects_path)
      end
    end # describe 'DELETE destroy'
  end # describe 'for admin users'
end # describe 'ProjectsController'
