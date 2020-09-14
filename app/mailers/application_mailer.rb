# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'bootstrap-mailer'
  add_template_helper(EmailHelper)
end
