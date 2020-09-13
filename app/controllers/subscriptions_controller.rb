class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    @subscriptions = @user.subscriptions.all
    @plan = @subscriptions.first.plan
  end

  def new
    @subscription = Subscription.new
  end

  def home
    @subscriptions = Subscription.all.to_a
    @subscriptions.unshift(@subscriptions.detect{|s| s.bill_day == Date.today.strftime("%d").to_i}).uniq
   
  end

  def create
    @plan = Plan.find(params[:plan_id])
    @subscription = @plan.subscriptions.new(subscription_params)
    if @subscription.save
      redirect_to user_session_path
    else
      render plain: 'No Subscription and No Transaction'
    end
  end

  def show
    @user = User.find(params[:user_id])
    @subscriptions = @user.subscriptions.all
    @plan = @subscriptions.first.plan

  end

  def edit; end

  def destroy; end

  private

  def subscription_params
    params.require(:subscription).permit(:user_id, :plan_id, :bill_day)
  end
end
