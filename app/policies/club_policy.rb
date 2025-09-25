class ClubPolicy < ApplicationPolicy

  def show?
    true
  end

  def join?
    user.present? && record.admin != user && !record.users.include?(user)
  end

  def joined?
    user.present? && (record.users.include?(user) || record.admin == user)
  end

  def edit?
    user.present? && (record.admin == user || user.admin? || user.moderator?)
  end

  def update?
    edit?
  end

  def destroy?
    user.present? && (record.admin == user || user.admin?)
  end

  def new?
    user.present?
  end

  def create?
    new?
  end

  def permitted_attributes
    if user.present? && (record.admin == user || user.admin? || user.moderator?)
      [:title, :description]
    else
      []
    end
  end


  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
