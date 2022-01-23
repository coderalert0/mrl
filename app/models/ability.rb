class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user

    alias_action :create, :read, :update, :destroy, to: :crud

    can :read, Speciality
    can :read, Program

    return if user.nil?

    return unless user.admin?

    can :crud, Program
    can :crud, Speciality
    can :crud, User
  end

  def edit_profile?
    user.admin? || !user.paid?
  end
end
