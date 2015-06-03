class AnswersController < ApplicationController
  before_action :load_question, only: [:create, :new, :edit, :destroy]
  before_action :load_answer, only: [:update, :edit, :destroy]

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.new(answer_params)
    if @answer.save
      redirect_to question_path(params[:question_id]),
                  notice: 'Ответ успешно создан'
    end
  end

  def update
    if @answer.update(answer_params)
      redirect_to question_path(params[:question_id]),
                  notice: 'Ответ обновлен'
    end
  end

  def destroy
    @answer.destroy
    redirect_to question_path(params[:question_id]),
                notice: 'Ответ удален'
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
