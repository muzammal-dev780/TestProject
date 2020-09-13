class PlanPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
  def create?
  	user.role == "admin"
  end
  def subscribed?
  	plan.find(params[:user_id])
  end
end
