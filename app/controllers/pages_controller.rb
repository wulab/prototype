class PagesController < ApplicationController
  def home
    @title = "Home"
    if signed_in?
      @micropost = Micropost.new
      @feed_items = current_user.feed.limit(5)
    end
  end

  def about
    @title = "About"
  end

end
