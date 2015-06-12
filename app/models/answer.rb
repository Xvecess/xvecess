class Answer < ActiveRecord::Base

  default_scope { order ('best DESC') }

  belongs_to :question
  belongs_to :user
  validates :body, :user_id, :question_id, presence: true

  def set_best_answer
    unless question.has_best_answer?
      update_attributes(best: true)
    end
  end
end