class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.present?
      if user.has_role? :admin
        can :manage, :all
      else
        can :read, Apartment, owner_id: user.id
      end
    end

  end
end
