# frozen_string_literal: true

# TransactionPolicy
class TransactionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
