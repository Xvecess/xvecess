module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable, dependent: :destroy
  end

  def vote_up(voter_user)
    unless voter_voted?(voter_user)
      vote = votes.create(user_id: voter_user.id)
      increment!(:vote_size)
      user.increment!(:vote_size)
      vote.update(vote_value: vote_size)
    end
  end

  def vote_down(voter_user)
    unless voter_voted?(voter_user)
      vote = votes.create(user_id: voter_user.id)
      decrement!(:vote_size)
      user.decrement!(:vote_size)
      vote.update(vote_value: vote_size)
    end
  end

  def change_vote_size

  end

  def voter_voted?(voter_user)
    votes.find_by_user_id(voter_user) ? true : false
  end
end