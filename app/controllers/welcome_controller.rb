# frozen_string_literal: true

# Welcome controller
class WelcomeController < ApplicationController
	skip_before_action :authenticate_user!
 def index
   @user = current_user
   @plans = Plan.all
   @subscriptions = @user.subscriptions.all if @user
 end
end
