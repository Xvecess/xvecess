class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_parent

  def vote_up
    respond_to do |format|
      unless @parent.user_id == current_user.id
        @parent.vote_up(current_user)
        format.json { render json: @parent }
      end
    end

  end

  def vote_down
    respond_to do |format|
      unless @parent.user_id == current_user.id
        @parent.vote_down(current_user)
        format.json { render json: @parent }
      end
    end
  end

  def destroy_vote
    respond_to do |format|
      @vote = Vote.find_by_votable_id(@parent)
      if @vote.user_id == current_user.id
        @vote.destroy
        @parent.vote_delete
      end
      format.json { render json: @parent }
    end
  end

  private

  def find_parent
    resource, id = request.path.split("/")[1, 2]
    @parent = resource.singularize.classify.constantize.find(id)
  end

end
