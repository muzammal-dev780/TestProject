class PlansController < ApplicationController
  before_action  :set_plan,  only: [:show, :edit, :update, :destroy]
  before_action :require_login

  def index
    
    @plans = Plan.all
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(plan_params)
    if @plan.save
      flash[:alert] ="Plan is created"
      redirect_to @plan
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @plan.update(plan_params)
      redirect_to @plan
    else
      render 'edit' 
    end
  end

  def show
  end

  def destroy
    @plan.destroy
    redirect_to user_session_path
  end

  private
    def set_plan
      @plan = Plan.find(params[:id])
    end
    def require_login
      if !current_user
        flash[:error] ="You have to login to access plans"
        redirect_to new_user_session_path
      end
    end
    def plan_params
      params.require(:plan).permit(:name, :fee)
    end
end
