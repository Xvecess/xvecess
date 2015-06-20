module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable, dependent: :destroy
  end

  def vote_up(voter_user)
    unless voter_voted?(voter_user)
      votes.create(user_id: voter_user.id)
      increment!(:vote_size)
      user.increment!(:vote_size)
    end
  end

  def vote_down(voter_user)
    unless voter_voted?(voter_user)
      votes.create(user_id: voter_user.id)
      decrement!(:vote_size)
      user.decrement!(:vote_size)
    end
  end

  def vote_delete
    if vote_size > 0
      decrement!(:vote_size)
    elsif vote_size < 0
      increment!(:vote_size)
    end
  end

  def voter_voted?(voter_user)
    votes.find_by_user_id(voter_user) ? true : false
  end
end