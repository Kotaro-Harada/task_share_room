class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_avatar
    @avatar = current_user.avatar
  end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
