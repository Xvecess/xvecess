class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: [:create]
  before_action :load_answer, only: [:update, :destroy, :best_answer]
  before_action :answer_user_compare, only: [:update, :destroy]

  def create
    @answer = @question.answers.create(answer_params.merge(user: current_user))
  end

  def update
     @answer.update(answer_params)
     @question = @answer.question
  end

  def destroy
    @answer.destroy
  end

  def best_answer
   @answer.set_best_answer
    redirect_to @answer.question
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body,:user_id, :question_id, attachments_attributes: [:file])
  end

  def answer_user_compare
    @answer = Answer.find(params[:id])
    if @answer.user_id != current_user.id
      redirect_to root_url, notice: 'Запрещено'
    end
  end
end
