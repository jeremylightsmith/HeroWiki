class Admin::UsersController < ApplicationController
  before_filter :authenticate_user!, :admin_required
  before_filter :load_user, :except => [:index, :new, :create]
  
  def index
    @users = User.find(:all, :order => 'name')
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to admin_users_path
    else
      render :action => 'new'
    end
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
  
  def confirm
    @user.confirm!
    redirect_to [:admin, :users]
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
