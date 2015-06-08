class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: [:create, :new]
  before_action :load_answer, only: [:update, :edit, :destroy]
  before_action :answer_user_compare, only: [:update, :destroy]

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.new(answer_params.merge(user: current_user))
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
    if @answer.destroy
      redirect_to @answer.question, notice: 'Ответ удален'
    end
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

  def answer_user_compare
    @answer = Answer.find(params[:id])
    if @answer.id != current_user.id
      return root_path, notice: 'Запрещено'
    end
  end
end
