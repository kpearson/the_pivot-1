class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :view, :all
      can :manage, Order
    else
      can :manage, Business, user_id: user.id
      can :create, Business
      can :view, User, id: user.id
      can :view, Order, user_id: user.id
    end
  end
end

