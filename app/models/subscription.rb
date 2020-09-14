# frozen_string_literal: true

class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :plan
  has_one   :usage
  has_many   :transactions
  validates :bill_day, inclusion: 1..28

  def calculate_payment(user,subscription)
	    plan = Plan.find(subscription.plan_id)
	    plan_fee = plan.fee
	    usage = subscription.usage
	    extraunits = usage.units_count    
	    feature = Feature.find(usage.feature_id)
	    featureunits = feature.max_unit_limit
	    unitprice = feature.unit_price
	    if extraunits > featureunits
	      eunits = extraunits - featureunits
	      feature_overuse = eunits * unitprice
	      plan_fee = plan_fee + feature_overuse
	    else
	      plan_fee = plan_fee
	    end
	end

end
