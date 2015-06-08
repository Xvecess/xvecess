class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_question, only: [:show, :edit, :update, :destroy]
  before_action :question_user_compare, only: [:update, :destroy]

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def show
    @answer = @question.answers.build
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      redirect_to questions_path, notice: 'Ваш вопрос добавлен'
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to @question, notice: 'Вопрос успешно обновлен'
    else
      render 'edit'
    end
  end

  def destroy
    redirect_to questions_path if @question.destroy
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def question_user_compare
    @question = Question.find(params[:id])
    if @question.user != current_user.id
      return root_path, notice: 'Запрещено'
    end
  end
end
