class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  belongs_to :user
  validates :title, :body, :user_id, presence: true
  validates :title, length: { in: 5..140 }

  def has_best_answer?
    (answers.find_by(best: true)) ? true : false
  end
end