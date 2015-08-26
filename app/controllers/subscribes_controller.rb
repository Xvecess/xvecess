class SubscribesController < ApplicationController

  respond_to :js
  authorize_resource

  def create
    @question = Question.find(params[:question_id])
    respond_with (@subscribe = current_user.subscribes.create(question: @question))
  end

  def destroy
    @subscribe = Subscribe.find(params[:id])
    respond_with (@subscribe.destroy)
  end
end
