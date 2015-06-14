class Question < ActiveRecord::Base

  default_scope { order ('created_at DESC') }

  has_many :answers, dependent: :destroy
  has_many :attachments, dependent: :destroy , as: :attachable
  belongs_to :user
  validates :title, :body, :user_id, presence: true
  validates :title, length: {in: 5..140}

  accepts_nested_attributes_for :attachments

  def has_best_answer?
    answers.find_by(best: true) ? true : false
  end
end