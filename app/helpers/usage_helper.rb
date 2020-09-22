# frozen_string_literal: true

# UsageHelper
module UsageHelper
  def specific_features(subscription)
    subscription.plan.features.map { |f| [f.name, f.id] }
  end
end
