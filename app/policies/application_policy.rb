# frozen_string_literal: true

# app policy
class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end
  # scope
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end

  def self.permit_admin_to(*actions)
    actions.each do |action|
      define_method("#{action}?") do
        admin?
      end
    end
  end

  def admin?
    @user.admin?
  end
end
