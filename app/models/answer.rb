class Answer < ActiveRecord::Base

  default_scope { order ('best DESC') }

  belongs_to :question
  belongs_to :user
  validates :body, :user_id, :question_id, presence: true

  def set_best_answer
    if question.has_best_answer?
      answer = question.answers.find_by(best: true)
      answer.update_attributes(best: false)
      update_attributes(best: true)
    else
      update_attributes(best: true)
    end
  end
end