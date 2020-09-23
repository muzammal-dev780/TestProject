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
      render 'new'
    end
  end

  private


  def send_welcome_mail(user)
    UserMailer.welcome_email(user).deliver_now
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role, :avatar)
  end
end
