module Voted
  extend ActiveSupport::Concern

  included do
    before_action :find_parent, only: [:vote_up, :vote_down, :destroy_vote]
  end

  def vote_up
    authorize! :vote_up, @parent
    @parent.vote_up(current_user)
    publish_vote
  end

  def vote_down
    authorize! :vote_down, @parent
    @parent.vote_down(current_user)
    publish_vote
  end

  def destroy_vote
    authorize! :destroy_vote, @parent
    @parent.destroy_vote(current_user)
    publish_vote
  end

  private

  def publish_vote
    @parent.reload
    render json: @parent, serializer: nil
  end
end