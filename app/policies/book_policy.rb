class BookPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    is_admin
  end

  def new?
    create?
  end

  def update?
    is_admin
  end

  def edit?
    update?
  end

  def destroy?
    is_admin
  end

  private
    def is_admin
      current_user.present?
    end
end
