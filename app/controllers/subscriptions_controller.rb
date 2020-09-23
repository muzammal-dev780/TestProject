# frozen_string_literal: true

# Subscription controller
class SubscriptionsController < ApplicationController
  before_action :set_user, only: %i[create]
  before_action :set_charge_user, only: %i[charge_user]
  before_action :set_create, only: %i[create]
  before_action :set_transaction, only: %i[charge_user]

  def index
    @subscriptions = policy_scope(Subscription)
    @plan = @subscriptions.first.plan if @subscriptions.any?
  end

  def new
    @plan = Plan.find(params[:plan_id])
    @subscription = Subscription.new
  end

  def home
    @subscriptions = Subscription.all.sort_by { |sub| sub.bill_day == Time.zone.today.strftime('%d').to_i ? 0 : 1 }
    authorize @subscriptions.first if @subscriptions.any?
  end

  def create
    if @subscription.save
      flash[:notice] = 'Subscription done successfully'
      redirect_to root_url
    else
      flash.now[:notice] = 'OOPS.. Subscription is not done successfully'
      render :new
    end
  end

  def show
    @user = User.first
    @subscriptions = Subscription.all
    @plan = @subscriptions.first.plan
  end

  def charge_user
    if @transaction.save
      send_charge_mail(@user,@transaction,@plan,@feature)
      flash[:notice] = 'User is charged successfully'
      redirect_to all_subscriptions_path
    else
      flash[:danger] = 'User is not charged successfully'
      redirect_to root_url
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(:plan_id, :bill_day)
  end

  def set_charge_user
    @subscription = Subscription.find(params[:id])
    @user = @subscription.user
    @plan = Plan.find(@subscription.plan_id)
  end

  def set_create
    @plan = Plan.find(params[:subscription][:plan_id])
    @subscription = Subscription.new(subscription_params)
    @subscription.user = @user
  end

  def set_transaction
    @transaction = Transaction.new(user_id: @user.id, subscription_id: @subscription.id,
                                   total_charges: @subscription.calculate_payment(@subscription, @features, @plan))
  end

  def set_user
    @user = current_user
  end

  def send_charge_mail(user,transaction,plan,feature)
    UserMailer.charge_user(user: user, transaction: transaction, plan: plan,
                      feature: feature).deliver_later
  end

  def usage_params
    params.require(:subscription).permit(:plan_id)
  end
end
