class UsageController < ApplicationController
  before_action :authenticate_user!
  def index
    @usages = Usage.all
	end

  def edit
    @usage = Usage.find(params[:id])
  end

  def update
    @usage = Usage.find(params[:id])
    if @usage.update(usage_params)
      redirect_to @usage
    else
      render 'edit'
    end
  end
  
  private
    def usage_params
      params.require(:usage).permit(:subscription_id,:user_id,:plan_id,:billing_day)
    end
end