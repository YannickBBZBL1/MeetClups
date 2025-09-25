class ActivityPolicy < ApplicationPolicy
  def index?
    user.present? && (user.admin? || user.moderator?)
  end

  class Scope < Scope
    def resolve
      return scope.all if user.admin?

      if user.moderator?
        scope.where.not(item_type: 'User')
      else
        scope.none
      end
    end
  end
end
