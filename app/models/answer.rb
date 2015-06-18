class Answer < ActiveRecord::Base

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

  def vote_up
    increment!(:vote_size)
    user.increment!(:vote_size)
  end

  def vote_down
    decrement!(:vote_size)
    user.decrement!(:vote_size)
  end

  def not_have_attachment (attributes)
    attributes['file'].blank?
  end
end