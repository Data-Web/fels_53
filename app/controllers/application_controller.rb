class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  protected
  
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in take access system"
      redirect_to login_path
    end
  end

  def login_redirect_admin
    unless logged_in? && is_admin?
      flash[:danger] = "You don't have permission to access on system"
      redirect_to root_path
    end
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in take access system"
      redirect_to login_path
    end
  end
end
