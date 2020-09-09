# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @plans = Plan.all
  end
end
