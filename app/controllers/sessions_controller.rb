class SessionsController < ApplicationController
  before_action :set_q
  def new
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "#{user.name} was logged in"
    else
      redirect_to sessions_new_path, alert: "Invalid email or password"
    end
  end

  def destroy
    reset_session
    redirect_to rooms_home_path, notice: "logged out"
  end

  def search
    @results = @q.result
  end

  def set_q
    @q = Room.ransack(params[:q])
  end

  private
  def session_params
    params.require(:session).permit(:email, :password)
  end
end
