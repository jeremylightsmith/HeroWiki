class ApplicationController < ActionController::Base
  layout :app_name
  
  protect_from_forgery

  helper_method :current_user, :can_admin?, :can_edit?, :page_path

  protected 

  def require_user!
    redirect_to sign_in_path unless current_user
  end

  def require_editor!
    if !current_user
      redirect_to sign_in_path
    elsif !current_user.editor?
      flash[:alert] = "Must be an editor to see this page"
      redirect_to root_path
    end
  end

  def require_admin!
    if !current_user
      redirect_to sign_in_path
    elsif !current_user.admin?
      flash[:alert] = "Must be an admin to see this page"
      redirect_to root_path
    end
  end

  def can_admin?
    current_user && current_user.admin?
  end

  def can_edit?
    current_user && current_user.editor?
  end

  def current_user
    if @current_user
      @current_user 
    elsif session[:user_id]
      @current_user = User.find(session[:user_id])
    else
      nil
    end
  end

  def current_user=(user)
    session[:user_id] = user ? user.id : nil
  end

  def page_path(page)
    "/#{page.url}"
  end
  
  def app_name
    ENV["APP_NAME"] || "hsd"
  end
end
