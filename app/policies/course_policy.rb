# Course policy
class CoursePolicy < ApplicationPolicy
  def index?
    true
  end

  def new?
    user.admin?
  end

  def create?
    new?
  end

  def show?
    true
  end

  def delete?
    user.admin?
  end

  def edit?
    new?
  end

  # Policy scope
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.instructor?
        scope.joins(:enrolments).where('user_id = :user_id', user_id: user.id)
      else
        scope
      end
    end
  end
end