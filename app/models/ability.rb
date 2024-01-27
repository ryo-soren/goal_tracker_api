# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)

    return unless user.present?
    can [:create, :read, :update, :destroy], Goal, user_id: user.id
    can [:read, :update, :destroy], User, id: user.id

  end
end
