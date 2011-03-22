class ProjectsController < ApplicationController
  before_filter :authenticate
  before_filter :admin_user, :only => :destroy
  
  def index
    @projects = Project.all
    @title = "Company projects"
  end

  def show
    @project = Project.find(params[:id])
    @title = "Project overview"
  end

  def new
    @project = Project.new
    @title = "Create project"
  end

  def edit
    @project = Project.find(params[:id])
    @title = "Edit project"
  end

  def create
    @project = Project.new(params[:project])
    @title = "Create project"

    if @project.save
      flash[:success] = "Project has successfully been created."
      redirect_to @project
    else
      render :action => "new"
    end
  end

  def update
    @project = Project.find(params[:id])
    @title = "Edit project"

    if @project.update_attributes(params[:project])
      flash[:success] = "Project has successfully been updated."
      redirect_to @project
    else
      render :action => "edit"
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash[:success] = "Project has successfully been deleted."
    redirect_to projects_path
  end
  
  def users
    @project = Project.find(params[:id])
    @users = @project.users.paginate(:page => params[:page], :per_page => 12)
    @title = "Project users"
    render 'users'
  end
  
end
