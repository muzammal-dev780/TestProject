# frozen_string_literal: true

# RegistrationsController
class User::RegistrationsController < Devise::RegistrationsController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.with(user: @user).welcome_email.deliver_now
      redirect_to new_user_session_path
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role, :avatar)
  end
end
