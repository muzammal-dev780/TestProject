# frozen_string_literal: true

# SubscriptionPolicy
class SubscriptionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user: user)
      end
    end
  end
  def home
    user.admin?
  end
  permit_admin_to :home, :all_subs
end
