module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable, dependent: :destroy
  end

  def vote_up(voter)
    unless voted_by? voter
      votes.create(user: voter, vote_value: 1)
    end
  end

  def vote_down(voter)
    unless voted_by? voter
      votes.create(user: voter, vote_value: -1)
    end
  end

  def destroy_vote(voter)
    vote = votes.find_by_user_id(voter)
    vote.destroy
  end

  def update_votes
    update(vote_sum: votes.sum(:vote_value))
  end

  protected

  def voted_by?(voter)
    votes.find_by_user_id(voter) ? true : false
  end
end