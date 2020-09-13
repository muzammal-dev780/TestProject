# frozen_string_literal: true

module PlansHelper
	def subscribed?(plan)
	  subscriptions.find_by(plan_id: plan.id)
	end
end
