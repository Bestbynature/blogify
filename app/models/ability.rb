class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user (not logged in)

    if user.role == 'admin'
      can :manage, :all
    else
      can :read, :all
      can :create, [Post, Comment, Like]
      can %i[destroy update], Post, author_id: user.id
      can %i[destroy update], Comment, user_id: user.id
    end
  end
end
