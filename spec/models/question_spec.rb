require 'rails_helper'

describe Question do

  let (:user) { create(:user) }
  let (:question) { create(:question, user_id: user.id) }
  let! (:answer) { create(:answer, user_id: user.id, question_id: question.id, best: true) }

  it { should validate_presence_of :title }

  it { should validate_presence_of :body }

  it { should validate_presence_of :user_id }

  it { should have_many(:answers).dependent(:destroy) }

  it { should validate_length_of(:title).
                  is_at_least(5).is_at_most(140) }

  it { should belong_to :user }

  describe 'question has best answer ?' do

    it 'return true if question has best answer' do
      expect(question.has_best_answer?).to be true
    end

    it 'return false if question no have best answer' do
      answer.update(best: false)
      expect(question.has_best_answer?).to be false
    end
  end
end
