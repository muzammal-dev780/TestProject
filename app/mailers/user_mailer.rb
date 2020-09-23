# frozen_string_literal: true

# UserMailer
class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def welcome_email(user)
    @user = user
    email_with_name = %("#{@user.name}" <#{@user.email}>)
    @url = 'http://localhost:3000/users/sign_in'
    make_bootstrap_mail(
      to: email_with_name,
      subject: 'Welcome to Muzammal-Test project app'
    )
  end

  def charge_user
    @user = params[:user]
    @transaction = params[:transaction]
    @plan = params[:plan]
    @feature = params[:feature]
    email_with_name = %("#{@user.name}" <#{@user.email}>)
    make_bootstrap_mail(
      to: email_with_name,
      subject: 'Charge slip of subscriptions'
    )
  end
end
