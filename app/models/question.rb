class Question < ActiveRecord::Base
  include Votable

  default_scope { order ('created_at DESC') }

  has_many :answers, dependent: :destroy
  has_many :subscribes,dependent: :destroy
  has_many :subscribed_users, through: :subscribes, source: :user
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :user
  validates :title, :body, :user_id, presence: true
  validates :title, length: {in: 5..140}

  accepts_nested_attributes_for :attachments, reject_if: :not_have_attachment

  def has_best_answer?
    answers.find_by(best: true) ? true : false
  end

  def not_have_attachment (attributes)
    attributes['file'].blank?
  end
end