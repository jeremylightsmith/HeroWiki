class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :can_edit?, :current_user

  protected 

  def can_edit?
    true
  end

  def current_user
  end
end
