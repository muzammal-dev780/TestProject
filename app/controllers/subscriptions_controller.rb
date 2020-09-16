class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    @subscriptions = @user.subscriptions.all
    @plan = @subscriptions.first.plan
  end

  def new
    @plan = Plan.find(params[:plan_id])
    @subscription = Subscription.new
  end

  def home
    @transactions = Transaction.all
    @subscriptions = Subscription.all.sort_by {|sub| sub.bill_day == (Date.today.strftime("%d").to_i) ? 0 : 1}
  end

  def create
    @user = current_user
    @plan = Plan.find(params[:subscription][:plan_id])
    @features = @plan.features.all  
    @subscription = Subscription.new(subscription_params)
    @subscription.user = @user
    ActiveRecord::Base.transaction do
      if @subscription.save!
        @features.each do |f|
          @usage = Usage.new(usage_params)
          @usage.user = @user
          @usage.feature_id = f.id
          @usage.subscription = @subscription
          @usage.save!
        end
        redirect_to new_user_session_path       
      else
        render plain: 'No Subscription and No Transaction created'
      end
    end
  end

  def show
    @user = User.first
    @subscriptions = Subscription.all
    @plan = @subscriptions.first.plan
  end
  def charge_user
    @subscription= Subscription.find(params[:subscription_id])
    @user=@subscription.user
    @plan = Plan.find(@subscription.plan_id)
    @features = @plan.features.all
    @transaction = Transaction.new(user_id:@user.id, subscription_id: @subscription.id, total_charges: @subscription.calculate_payment(@subscription,@features,@plan))
    ActiveRecord::Base.transaction do
      if @transaction.save
        UserMailer.with(user: @user, transaction: @transaction,plan: @plan, feature:@feature).charge_user.deliver_now
         redirect_to all_subscriptions_path
      else
        redirect_to new_user_session_path
       end
     end
  end
  def edit; end

  def destroy; end

  private
    def subscription_params
      params.require(:subscription).permit(:plan_id, :bill_day)
    end
    def usage_params
      params.require(:subscription).permit(:plan_id)
    end
end
