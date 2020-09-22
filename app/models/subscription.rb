# frozen_string_literal: true

# Subscription model
class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :plan
  has_many   :usages, dependent: :destroy
  has_many   :transactions
  validates  :bill_day, inclusion: 1..28

  def calculate_payment(subscription, _features, plan)
    plan_fee = plan.fee
    usages = subscription.usages.all
    usages.each do |usage|
      plan_fee = if usage.units_count > usage.feature.max_unit_limit
                   plan_fee + (usage.feature.unit_price * (usage.units_count - usage.feature.max_unit_limit))
                 else
                   plan_fee
                 end
    end
    plan_fee = plan_fee
  end
end
