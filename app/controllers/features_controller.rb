# frozen_string_literal: true

class FeaturesController < ApplicationController
  before_action :authenticate_user!

  def index
    @plan = Plan.find(params[:plan_id])
    @features = @plan.features.all
  end

  def new
    @plan = Plan.find(params[:plan_id])
    @feature = Feature.new
  end

  def create
    @plan = Plan.find(params[:plan_id])
    @feature = @plan.features.create(feature_params)
    redirect_to plan_path(@plan)
  end

  def edit
    @feature = Feature.find(params[:id])
  end

  def update
    @feature = Feature.find(params[:id])
    if @feature.update(feature_params)
      redirect_to plans_path
    else
      render 'edit'
    end
  end

  def show
    @plan = Plan.find(params[:plan_id])
    @feature = Feature.find(params[:id])
  end

  def destroy
    @feature = Feature.find(params[:id])
    @feature.destroy
    respond_to do |format|
      format.html { redirect_to user_session_path, success: 'Feature was successfully deleted.' }
    end
  end

  private

  def feature_params
    params.require(:feature).permit(:name, :code, :unit_price, :max_unit_limit, :plan_id)
  end
end
