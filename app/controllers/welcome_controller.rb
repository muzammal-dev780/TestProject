# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
  	@user = current_user
    @plans = Plan.all
    @subscriptions = @user.subscriptions.all if @user 
    
  end
end
