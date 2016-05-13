class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can [:read, :create, :like], Flashcard
      can [:update], Flashcard do |flashcard|
        flashcard.owned_by?(user)
      end
    end
  end
end
