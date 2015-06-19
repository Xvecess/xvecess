class Answer < ActiveRecord::Base
  include Votable

  default_scope { order ('best DESC') }

  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachable, dependent: :destroy
  validates :body, :user_id, :question_id, presence: true

  accepts_nested_attributes_for :attachments, reject_if: :not_have_attachment

  def set_best_answer
    if question.has_best_answer?
      answer = question.answers.find_by(best: true)
      answer.update_attributes(best: false)
    end
    update_attributes(best: true)
  end

  def not_have_attachment (attributes)
    attributes['file'].blank?
  end
end