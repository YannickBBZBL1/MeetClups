class MeetupPolicy < ApplicationPolicy

  def show?
    user.present? && (record.club.users.include?(user) || record.club.admin == user || user.admin? || user.moderator?)
  end

  def edit?
    (user.present? && record.organizer == user) || user.admin? || user.moderator?
  end

  def update?
    edit?
  end

  def destroy?
    (user.present? && record.organizer == user) || user.admin?
  end

  def new?
    user.present?
  end

  def create?
    new?
  end

  def participate?
    user.present? && !record.users.include?(user) && (record.users.count < record.max_participants || record.max_participants == 0)
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
