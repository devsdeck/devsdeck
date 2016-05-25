class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can [:read, :create, :like], Card
      can [:update], Card do |card|
        card.owned_by?(user)
      end
      can [:read], User
      can [:update], User do |userr|
        userr == user
      end
    end
  end
end
