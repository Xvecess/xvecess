class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    return guest_abilities if user.nil?
    @user = user
    send("#{user.status}_abilities")
  end

  def guest_abilities
    can :read, [Question, Answer, Comment, User]
  end

  def confirmed_user_abilities
    guest_abilities

    can :create, [Answer, Attachment, Comment, Question, Vote]
    can :create, [Authorization], user: @user

    can :update, [Answer, Comment, Question], user: @user

    can :destroy, [Answer, Comment, Question], user: @user
    can :destroy, [Attachment] do |attachment|
      attachment.attachable.user_id == @user.id
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
      answer.question.user_id == @user.id && !answer.best
    end
  end

  def admin_abilities
    can :manage, :all
  end
end
