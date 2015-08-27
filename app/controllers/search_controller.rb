class SearchController < ApplicationController
  before_action :load_query, :load_target, only: :search
  before_action :load_target, only: :search

  def search
    case @target
      when 'questions'
        @result = Question.search(@query)
      when 'answers'
        @result = Answer.search(@query)
      when 'comments'
        @result = Comment.search(@query)
      when 'users'
        @result = User.search(@query)
    end
  end

  private

  def load_target
    @target = params[:target]
  end

  def load_query
    @query = params[:query]
  end
end
