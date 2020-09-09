class SubscriptionsController < ApplicationController
	before_action :authenticate_user!
  
  def index
    @user = User.find (params[:user_id])
    @subscriptions = @user.subscriptions.all
  end

	def new
    @subscription = Subscription.new  
  end

  def create
    @plan = Plan.find (params[:plan_id])
    @subscription = @plan.subscriptions.new(subscription_params)
    if @subscription.save
      redirect_to user_session_path
    else
      render plain: "No Subscription and No Transaction"
    end
	end

  def show
  end
  
  def edit
  end

  def destroy
  end  

  private
    def subscription_params
      params.require(:subscription).permit(:user_id, :plan_id, :bill_day)
    end
end
