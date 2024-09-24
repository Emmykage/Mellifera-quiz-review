# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :read, Message
      can :create, Message
      can :reply, Message, sender_id: user.id
      can :update, Message, sender_id: user.id
      can :destroy, Message, sender_id: user.id
    end


  end
end
