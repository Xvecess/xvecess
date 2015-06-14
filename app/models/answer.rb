class Answer < ActiveRecord::Base

  default_scope { order ('best DESC') }

  belongs_to :question
  belongs_to :user
  has_many :attachments , dependent: :destroy, as: :attachable
  validates :body, :user_id, :question_id, presence: true

  accepts_nested_attributes_for :attachments

  def set_best_answer
    if question.has_best_answer?
      answer = question.answers.find_by(best: true)
      answer.update_attributes(best: false)
    end
    update_attributes(best: true)
  end
end