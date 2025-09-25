class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.moderator?
        scope.where(role: [:user, :moderator])
      else
        scope.none
      end
    end
  end

  def index?
    user.admin? || user.moderator?
  end

  def edit?
    user.admin? || (user.moderator? && record.role != 'admin')
  end

  def update?
    edit?
  end
end