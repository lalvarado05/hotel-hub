# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    # Permissions for guest users (not logged in)
    can :read, Room, public: true
    can :search, Room # Allow guests to access the search action

    # Additional permissions for logged in users
    if user.client?
      can :read, Room                           # Allow clients to read rooms
      can :create, Reservation                  # Allow clients to create reservations
      can :read, Reservation, user_id: user.id  # Allow users to read their own reservations
    end

    # Additional permissions for admin users
    if user.admin?
      can :manage, :all # Admins can manage everything
    end


    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end
