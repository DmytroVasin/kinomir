class Ability
  include CanCan::Ability

  def initialize(user)
    
    user ||= User.new

    if user.roles.first.nil?
        can :read, Post
    #not logged
    elsif user.roles.first.name == "user"
        #loged in as user
        can :read, Post
        can :create, Post
        can :update, Post, :user_id => user.id
        can :destroy, Post , :user_id => user.id 

        can :create, Comment

        can :update, Vote do |vote|
            !vote.users.include?(user)   
        # он может делать update для Vote - голоcовать ( если еще не голосовал )
        end

    elsif user.roles.first.name == "admin"
        # login as admin
        can :manage, Post # Поставил пост а не :all если будет :all то сможет голосовать вечно

        can :clear, Vote 
        can :update, Vote do |vote|
            !vote.users.include?(user)   
        end
    end

  end
end
