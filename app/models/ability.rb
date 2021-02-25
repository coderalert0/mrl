class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, to: :crud

    return if user.nil?

    if user.admin?
      can :crud, Program
      can :crud, Speciality
    else
      can :read, Speciality
      can :read, Program
    end
  end
end
