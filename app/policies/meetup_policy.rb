class MeetupPolicy < ApplicationPolicy

  def show?
    user.present? && record.users.include?(user)
  end

  def edit?
    user.present? && record.organizer == user
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  def new?
    user.present?
  end

  def create?
    new?
  end

  def participate?
    user.present? && !record.users.include?(user) && record.users.count < record.max_participants
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
