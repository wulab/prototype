class TasksController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @tasks = @project.tasks.paginate(:page => params[:page], :per_page => 6)
    @title = "Project tasks"
  end
  
  def new
    @project = Project.find(params[:project_id])
    @task = @project.tasks.build
  end

  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.build(params[:task])
    
    if @task.save
      flash[:success] = "Task has been successfully created."
      redirect_to project_tasks_path(@project)
    else
      render :action => "new"
    end
  end

end
