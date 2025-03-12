# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  # Only admins can see all users
  def index?
    user.admin?
  end

  # Admins can see any user; users can see themselves
  def show?
    user.admin? || user == record
  end

  # Only admins can create new users
  def create?
    user.admin?
  end

  # Users can update their own profile; admins can update anyone
  def update?
    user.admin? || user == record
  end

  # Only admins can delete users, but not themselves
  def destroy?
    user.admin? && user != record
  end

  # Scope for restricting access
  # class Scope < Scope
  #   def resolve
  #     if user.admin?
  #       scope.all
  #     else
  #       scope.where(id: user.id) # Regular users can only see themselves
  #     end
  #   end
  # end
end
