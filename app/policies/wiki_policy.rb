class WikiPolicy < ApplicationPolicy

  def update?
    if record.private?
      user.present? and record.user_id == user.id
    else
      user.present?
    end
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
