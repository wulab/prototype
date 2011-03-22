class MembershipsController < ApplicationController
  before_filter :authenticate
  before_filter :admin_user
  
  def create
    #render :text => params.inspect
    @project = Project.find(params[:membership][:project_id])
    @user = User.find(params[:membership][:user_id])
    @membership = @project.memberships.build(:user_id => @user.id)
    
    if @membership.save
      redirect_to users_project_path(@project)
    else
      flash[:error] = "Can not add that user."
      redirect_to users_project_path(@project)
    end
  end
  
  def destroy
    #render :text => params.inspect
    @membership = Membership.find(params[:id])
    @project = @membership.project
    @membership.destroy
    redirect_to users_project_path(@project)
  end
  
end
