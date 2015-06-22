module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable, dependent: :destroy
  end

  def vote_up(voter_user)
    unless voter_voted?(voter_user)
      votes.create(user_id: voter_user.id)
      update(vote_sum: self.vote_sum + 1)
    end
  end

  def vote_down(voter_user)
    unless voter_voted?(voter_user)
      votes.create(user_id: voter_user.id)
      update(vote_sum: self.vote_sum - 1)
    end
  end

  def  change_vote_size(voter_user)
    vote = self.votes.find_by_user_id(voter_user)
    if vote_sum < 0
    update(vote_sum: self.vote_sum - 1)
    elsif vote_sum < 0
    update(vote_sum: self.vote_sum + 1)
    end
    vote.destroy
  end

  def voter_voted?(voter_user)
    votes.find_by_user_id(voter_user) ? true : false
  end
end