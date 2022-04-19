class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  private

  def ensure_current_user
    redirect_to root_path, alert: 'You must be logged in!' unless current_user
  end
end
