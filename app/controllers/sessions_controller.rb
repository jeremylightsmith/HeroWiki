class SessionsController < ApplicationController
  before_filter :require_user!, only:[:destroy, :unlock]

  def new
  end

  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    self.current_user = @user
    if current_user.editor?
      flash[:notice] = "Welcome back, #{current_user.name}"
      redirect_to root_path
    else
      flash[:notice] = "Welcome, #{current_user.name}"
      redirect_to "/welcome"
    end
  end

  def failure
    flash[:alert] = params[:message]
    redirect_to root_path
  end

  def destroy
    self.current_user = nil
    redirect_to root_path
  end

  def unlock
    if params[:password] == UNLOCK_PASSWORD
      current_user.editor = true
      current_user.save!
      flash[:notice] = "Congratulations, you can now edit this site!"

      redirect_to root_path
    else
      flash[:alert] = "This doesn't seem to be the correct password, please try again"
      redirect_to "/welcome"
    end
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end

