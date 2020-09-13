# frozen_string_literal: true

class FeaturesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @plan = Plan.find(params[:plan_id])
    @features = @plan.features.all
  end

  def new
    @user = current_user
    @plan = Plan.find(params[:plan_id])
    @feature = Feature.new
  end

  def create
    @user = current_user
    @plan = Plan.find(params[:plan_id])
    @feature = @plan.features.create(feature_params)
    redirect_to feature_path(@feature)
  end

  def edit
    @user = current_user
    @feature = Feature.find(params[:id])
  end

  def update
    @user = current_user
    @feature = Feature.find(params[:id])
    if @feature.update(feature_params)
      redirect_to plans_path
    else
      render 'edit'
    end
  end

  def show
    @user = current_user
    @plan = Plan.find(params[:plan_id])
    @feature = Feature.find(params[:id])
  end

  def destroy
    @user = current_user
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
