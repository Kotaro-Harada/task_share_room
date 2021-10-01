class Admin::UsersController < ApplicationController
  before_action :set_q
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    avatar_path = Rails.root.join("app", "assets", "images", "default_icon.jpeg")
    file = File.open(avatar_path)
    @user.avatar.attach(io: file, filename: "default_icon.jpeg")

    if @user.save
      redirect_to rooms_home_path, notice: "User, #{@user.name} was registered."
    else
      render "new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = @w.result
  end

  def update
    @user = User.find(params[:id])
    if @user&.authenticate(params.require(:user).permit(:current_password)[:current_password]) || params.require(:user).permit(:current_password)[:current_password] == current_user.password_digest
      if @user.update(user_params)
        redirect_to admin_user_path(@user), notice: "User #{@user.name} was updated."
      elsif params.require(:user).permit(:current_password)[:current_password] == current_user.password_digest
        render "profile"
      else
        render "edit"
      end
    else
      redirect_to edit_admin_user_path, alert: "現在のパスワードが一致しません。"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "User #{@user.name} was deleted."
  end

  def search
    @results = @q.result
  end

  def set_q
    @q = Room.ransack(params[:q])
    @w = User.ransack(params[:w])
  end

  def profile
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :introduction, :avatar, :admin,)
  end
end
