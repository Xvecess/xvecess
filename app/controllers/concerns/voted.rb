module Voted
  extend ActiveSupport::Concern

  included do
    before_action :find_parent, only: [:vote_up, :vote_down, :destroy_vote]
  end

  def vote_up
    unless @parent.user_id == current_user.id
      @parent.vote_up(current_user)
      @parent.reload
    end
    render json: @parent
  end

  def vote_down
    unless @parent.user_id == current_user.id
      @parent.vote_down(current_user)
      @parent.reload
    end
    render json: @parent
  end

  def destroy_vote
    @parent.destroy_vote(current_user)
    @parent.reload
    render json: @parent
  end

  private

  def parent_klass
    controller_name.classify.constantize
  end

  def find_parent
    @parent = parent_klass.find(params[:id])
  end
end