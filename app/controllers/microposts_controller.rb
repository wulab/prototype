class MicropostsController < ApplicationController
  before_filter :authenticate
  before_filter :authorized_user, :only => :destroy
  
  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created."
      redirect_to dashboard_path
    else
      @feed_items = current_user.feed.limit(5)
      render 'pages/dashboard'
    end
  end
  
  def destroy
    @micropost.destroy
    redirect_back_or dashboard_path
  end
  
  private
    
    def authorized_user
      @micropost = Micropost.find(params[:id])
      redirect_to root_path unless current_user?(@micropost.user)
    end
  
end
