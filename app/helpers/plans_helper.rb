# frozen_string_literal: true

# PlansHelper
module PlansHelper
  def subscribed?(plan)
    subscriptions.find_by(plan_id: plan.id)
  end
end
