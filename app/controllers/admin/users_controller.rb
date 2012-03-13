class Admin::UsersController < ApplicationController
  before_filter :require_admin!
  before_filter :load_user, :except => [:index, :new, :create]
  
  def index
    @users = User.find(:all, :order => 'name')
  end
  
  def new
    @user = User.new
  end
  
  def show
  end
  
  def update
    params[:user].each do |k,v|
      @user.send("#{k}=", v)
    end
    if @user.save
      redirect_to admin_users_path
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @user.destroy
    
    flash[:notice] = "#{@user.name} deleted"
    redirect_to admin_users_path
  end
  
  private 
  
  def load_user
    @user = User.find(params[:id])
  end
end
