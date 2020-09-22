# frozen_string_literal: true

# UsagePolicy
class UsagePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
  permit_admin_to :index, :edit, :update, :new, :create, :update
  def all_sbs?
    user.admin
  end
end
