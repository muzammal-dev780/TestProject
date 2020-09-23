# frozen_string_literal: true

# RegistrationsController
class User::RegistrationsController < Devise::RegistrationsController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      send_welcome_mail(@user)
      redirect_to new_user_session_path
    else
      render :new
    end
  end

  def update
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    if current_user.update(user_params)
      redirect_to root_url
    else
      render :edit
    end
  end

  private

  def send_welcome_mail(user)
    UserMailer.welcome_email(user).deliver_later
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role, :avatar, :avatar_cache)
  end
end
