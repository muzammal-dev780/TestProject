class UsageController < ApplicationController
  before_action :authenticate_user!
  before_action :set_usage , only: %i[show edit update destroy]

  def index
    @usages = Usage.all
	end

  def edit
  end

  def update
    if @usage.update(usage_params)
      redirect_to usage_index_path
    else
      render 'edit'
    end
  end
  
  private
    def set_usage
    @usage = Usage.find(params[:id])
    end
    def usage_params
      params.require(:usage).permit(:units_count)
    end
end