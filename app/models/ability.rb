class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    if user 
      if user.admin?
        can :manage, Project
        can :manage, Task        
      end
      if user.developer?
        can :index, Project, {projects_users: {user_id: user.id}}
        can :show, Project
        can [:show, :index, :change_status], Task, user_id: user.id
        cannot [:new, :create, :edit, :update, :destroy], Task
        cannot [:new, :create, :edit, :update, :destroy], Project
      end
    end
  end
end
