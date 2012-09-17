class Ability
  include CanCan::Ability

  def initialize(user)
    
    user ||= User.new

    if user.roles.first.nil?
        can :read, Post
    #not logged
    elsif user.roles.first.name == "user"
        #loged in
        can :read, Post
        can :create, Post
        can :update, Post, :user_id => user.id
        can :destroy, Post , :user_id => user.id 

        can :create, Comment
        
    elsif user.roles.first.name == "admin"
        can :manage, :all
    end

  end
end
