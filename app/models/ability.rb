class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, to: :crud

    can :read, Speciality
    can :read, Program

    return if user.nil?

    if user.admin?
      can :crud, Program
      can :crud, Speciality
    end
  end
end
