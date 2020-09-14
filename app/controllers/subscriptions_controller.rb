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
    @subscriptions = Subscription.all.sort_by {|sub| sub.bill_day == (Date.today.strftime("%d").to_i) ? 0 : 1}
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
  def charge_user
    @subscription= Subscription.find(params[:subscription_id])
    @user=@subscription.user
    @plan = Plan.find(@subscription.plan_id)
    @usage = @subscription.usage    
    @feature = Feature.find(@usage.feature_id)
    @transaction = Transaction.new(user_id:@user.id, subscription_id: @subscription.id, total_charges: @subscription.calculate_payment(@user,@subscription))
    if @transaction.save
      UserMailer.with(user: @user, transaction: @transaction,plan: @plan, feature:@feature).charge_user.deliver_now
       redirect_to all_subscriptions_path
    else
      redirect_to new_user_session_path
     end
  end
  def edit; end

  def destroy; end

  private

  def subscription_params
    params.require(:subscription).permit(:user_id, :plan_id, :bill_day)
  end
end
