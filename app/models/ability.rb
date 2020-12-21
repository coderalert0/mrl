class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, to: :crud

    return if user.nil?

    can :crud, Speciality
    can :crud, Program
  end
end
