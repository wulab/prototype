class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy
  
  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page], :per_page => 12)
  end
  
  def new
    redirect_to root_path if signed_in?
    @user = User.new
    @title = "Sign up"
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page], :per_page => 10)
    @title = @user.name
    store_location
  end
  
  def create
    redirect_to root_path if signed_in?
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome to the Project Management App!"
      sign_in @user
      redirect_to @user
    else
      @title = "Sign up"
      @user.password = nil
      @user.password_confirmation = nil
      render 'new'
    end
  end
  
  def edit
    @title = "Edit user"
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
  def destroy
    user = User.find(params[:id])
    if user.admin?
      redirect_to users_path
    else
      user.destroy
      flash[:success] = "User has successfully been destroyed."
      redirect_to users_path
    end
  end
  
  private
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
    
end
