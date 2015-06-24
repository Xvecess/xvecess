class User < ActiveRecord::Base
  has_many :questions
  has_many :answers
  has_many :votes, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def voted?(votable)
    votes.find_by_votable_id(votable) ? true : false
  end
end