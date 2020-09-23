# frozen_string_literal: true

# Usage controller
class UsagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_usage, only: %i[edit update]
  before_action :set_subscription, only: %i[index new create]
  before_action :set_usage_to_create, only: %i[create]

  def index
    @usages = @subscription.usages.all
    authorize @usages
  end

  def all_subs
    @subscriptions = Subscription.all
    authorize @subscriptions
  end

  def new
    @usage = @subscription.usages.new
    authorize @usage
  end

  def create
    if @usage.save
      authorize @usage
      redirect_to root_url
    else
      render :new
    end
  rescue ActiveRecord::RecordNotUnique
    flash[:danger] = 'you cannot add usage of already added feature'
    redirect_to subscription_usages_path(@subscription)
  end

  def home
    @usages = Usage.all
  end

  def edit
    @usage = Usage.find(params[:id])
    authorize @usage
  end

  def update
    if @usage.update(usage_params)
      authorize @usage
      flash[:notice] = 'Usage updated successfully'
      redirect_to root_url
    else
      render :edit
    end
  end

  private

  def set_usage
    @usage = Usage.find(params[:id])
  end

  def set_usage_to_create
    @usage = @subscription.usages.new(usage_params)
    @usage.plan = @subscription.plan
    @usage.user = @subscription.user
    @usage.subscription = @subscription
  end

  def set_subscription
    @subscription = Subscription.find(params[:subscription_id])
  end

  def usage_params
    params.require(:usage).permit(:units_count, :feature_id)
  end
end
