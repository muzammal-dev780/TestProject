# frozen_string_literal: true

# UserPolicy
class UserPolicy < ApplicationPolicy
  delegate :admin?, to: :user

  def buyer?
    user.role == 'user'
  end

  def user?
    user.role == 'admin' || user.role == 'user'
  end
end
