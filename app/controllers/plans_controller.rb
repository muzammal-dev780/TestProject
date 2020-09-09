# frozen_string_literal: true

class PlansController < ApplicationController
  before_action :set_plan, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    @plans = Plan.all
  end

  def new
    @plan = Plan.new
    authorize @plan
  end

  def create
    @plan = Plan.new(plan_params)
    authorize @plan
    if @plan.save
      flash[:alert] = 'Plan is created'
      redirect_to @plan
    else
      render 'new'
    end
  end

  def edit
    @user = current_user
   end

  def update
    if @plan.update(plan_params)
      redirect_to @plan
    else
      render 'edit'
    end
  end

  def show; end

  def destroy
    @plan.destroy
    redirect_to user_session_path
  end

  private
  def set_plan
    @plan = Plan.find(params[:id])
  end

  def require_login
    unless current_user
      flash[:error] = 'You have to login to access plans'
      redirect_to new_user_session_path
    end
  end

  def plan_params
    params.require(:plan).permit(:name, :fee)
  end
end
