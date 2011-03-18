class PagesController < ApplicationController
  def home
    @title = "Home"
  end
  
  def dashboard
    redirect_to root_path unless signed_in?
    @micropost = Micropost.new
    @feed_items = current_user.feed.limit(5)
    @title = "Dashboard"
  end

  def about
    @title = "About"
  end

end
