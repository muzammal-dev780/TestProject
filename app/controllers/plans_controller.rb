# frozen_string_literal: true

# Plans controller
class PlansController < ApplicationController
  before_action :set_plan, only: %i[edit update destroy]
  before_action :authenticate_user!

  def index
    @plans = Plan.all
    flash.now[:notice] = "We have exactly #{@plans.size} plans available."
  end

  def new
    @plan = Plan.new
    authorize @plan
  end

  def create
    @plan = Plan.new(plan_params)
    authorize @plan
    if @plan.save
      flash[:alert] = 'Plan is created successfully'
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
    @user = current_user
    authorize @plan
  end

  def update
    authorize @plan
    if @plan.update(plan_params)
      flash[:alert] = 'Plan is updated successfully'
      redirect_to root_url
    else
      render :edit
    end
  end

  def destroy
    authorize @plan
    @plan.destroy
    flash[:destroy] = 'Plan is destroyed successfully'
    redirect_to root_url
  end

  private

  def set_plan
    @plan = Plan.find(params[:id])
  end

  def plan_params
    params.require(:plan).permit(:name, :fee)
  end
end
