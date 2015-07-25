class Ability
  include CanCan::Ability

  def initialize(user)
    return quest_abilities if user.nil?
    @user = user

    case user.status
      when 'quest' then
        quest_abilities
      when 'admin' then
        admin_abilities
      when 'confirmed_user' then
        confirmed_user_abilities
    end

  end

  def quest_abilities
    can :read, [Question, Answer, Comment, User]
  end

  def confirmed_user_abilities
    quest_abilities

    can :create, [Answer, Attachment, Comment, Question, Vote]
    can :create, [Authorization], user: @user

    can :update, [Answer, Comment, Question], user: @user

    can :destroy, [Answer, Comment, Question], user: @user
    can :destroy, [Attachment] do |attachment|
      attachment.attachable.user == @user
    end

    can :vote_up, [Question, Answer] do |votable|
      votable.user != @user && !@user.voted?(votable)
    end
    can :vote_down, [Question, Answer] do |votable|
      votable.user != @user && !@user.voted?(votable)
    end
    can :destroy_vote, [Question, Answer] do |votable|
      votable.user != @user
    end

    can :best_answer, Answer do |answer|
      answer.question.user == @user && !answer.best
    end
  end

  def admin_abilities
    can :manage, :all
  end
end
