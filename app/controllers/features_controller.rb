# frozen_string_literal: true

# Feature controller
class FeaturesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_plan
  before_action :set_feature, except: %i[index new create]

  def index
    @features = @plan.features.all
    flash.now[:notice] = "We have exactly #{@features.size} features available of #{@plan.name} plan."
  end

  def new
    @feature = Feature.new
    authorize @feature
  end

  def create
    @feature = @plan.features.new(feature_params)
    if @feature.save
      flash[:success] = 'Feature created successfully'
      authorize @feature
      redirect_to root_url

    else
      flash.now[:danger] = 'Feature not created successfully'
      render :new
    end
  end

  def edit
    authorize @feature
  end

  def update
    if @feature.update(feature_params)
      authorize @feature
      flash[:success] = 'Feature updated successfully'
      redirect_to root_url
    else
      render :edit
    end
  end

  def show; end

  def destroy
    authorize @feature
    @feature.destroy
    respond_to do |format|
      format.html { redirect_to root_url, success: 'Feature was successfully deleted.' }
    end
  end

  private

  def set_plan
    @plan = Plan.find(params[:plan_id])
  end

  def set_user
    @user = current_user
  end

  def set_feature
    @feature = Feature.find(params[:id])
  end

  def feature_params
    params.require(:feature).permit(:name, :code, :unit_price, :max_unit_limit, :plan_id)
  end
end
