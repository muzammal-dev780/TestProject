# frozen_string_literal: true

# FeaturePolicy
class FeaturePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  permit_admin_to :new, :edit, :update, :create, :destroy
end
