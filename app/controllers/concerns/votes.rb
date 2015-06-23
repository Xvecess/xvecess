module Votes
  extend ActiveSupport::Concern

  included do
    before_action :find_parent, only: [:vote_up, :vote_down, :destroy_vote]
  end

  def vote_up
    respond_to do |format|
      unless @parent.user_id == current_user.id
        @parent.vote_up(current_user)
        @parent.reload
        format.json { render json: @parent }
      end
    end
  end

  def vote_down
    respond_to do |format|
      unless @parent.user_id == current_user.id
        @parent.vote_down(current_user)
        @parent.reload
        format.json { render json: @parent }
      end
    end
  end

  def destroy_vote
    respond_to do |format|
      @parent.destroy_vote(current_user)
      @parent.reload
      format.json { render json: @parent }
    end
  end

  private

  def find_parent
    resource, id = request.path.split("/")[1, 2]
    @parent = resource.singularize.classify.constantize.find(id)
  end
end