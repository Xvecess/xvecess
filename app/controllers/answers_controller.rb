class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: [:create, :new, :edit, :destroy]
  before_action :load_answer, only: [:update, :edit, :destroy]

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.new(answer_params.merge(user_id: current_user.id))
    if @answer.save
      redirect_to @question, notice: 'Ответ успешно создан'
    else
      render :new
    end
  end

  def update
    if @answer.update(answer_params)
      redirect_to @answer.question, notice: 'Ответ обновлен'
    else
      render :edit
    end
  end

  def destroy
    @answer.destroy
    redirect_to @answer.question, notice: 'Ответ удален'
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
