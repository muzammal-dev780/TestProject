# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def welcome_email
    @user = params[:user]
    email_with_name = %("#{@user.name}" <#{@user.email}>)
    @url = 'http://example.com/login'
    mail(to: email_with_name, subject: 'Welcome to My Awesome Site')
  end
end
