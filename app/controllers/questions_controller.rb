class QuestionsController < ApplicationController
  include Voted
  include PublicIndex
  include PublicShow
  before_action :load_question, only: [:show, :edit, :update, :destroy]
  before_action :question_user_compare, only: [:update, :destroy]

  authorize_resource

  def index
    respond_with @questions = Question.all
  end

  def new
    @question = Question.new
    @question.attachments.build
  end

  def show
    @answer = @question.answers.build
    @answer.attachments.build
  end

  def edit
    @question.attachments.build
  end

  def create
    respond_with @question = current_user.questions.create(question_params),
                 location: questions_path
  end

  def update
    @question.update(question_params)
    respond_with @question, location: @question
  end

  def destroy
   respond_with @question.destroy, location: @questions
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:file])
  end

  def question_user_compare
    @question = Question.find(params[:id])
    if @question.user_id != current_user.id
      redirect_to root_url, notice: 'Запрещено'
    end
  end
end
