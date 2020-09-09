class UserPolicy < ApplicationPolicy
  def admin?
  	user.role == "admin"
  end
  def buyer?
  	user.role == "user"
  end
  def user?
  	user.role == "admin" || user.role == "user"
  end
end
