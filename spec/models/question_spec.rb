require 'rails_helper'

describe Question do

  let (:user) { create(:user) }
  let (:user2) { create(:user) }
  let (:question) { create(:question, user_id: user.id) }
  let! (:answer) { create(:answer, user_id: user.id, question_id: question.id, best: true) }

  it { should validate_presence_of :title }

  it { should validate_presence_of :body }

  it { should validate_presence_of :user_id }

  it { should have_many(:answers).dependent(:destroy) }

  it { should have_many(:attachments).dependent(:destroy) }

  it { should validate_length_of(:title).
                  is_at_least(5).is_at_most(140) }

  it { should belong_to :user }

  it { should accept_nested_attributes_for :attachments }

  it { should have_many(:votes).dependent(:destroy) }

  describe 'question has best answer ?' do

    it 'return true if question has best answer' do
      expect(question.has_best_answer?).to be true
    end

    it 'return false if question no have best answer' do
      answer.update(best: false)
      expect(question.has_best_answer?).to be false
    end
  end

  describe 'question not have attachment' do

    it 'expecting true if no have attachment' do
      expect(question.not_have_attachment(question: ['file'])).to eq true
    end
  end

  describe 'vote voted' do

    it 'create new vote with value 1' do
      question.votes.create(user: user2, vote_value: 1)
      question.reload
      expect(question.vote_sum).to eq 1
    end

    it 'create new vote with value -1' do
      question.votes.create(user: user2, vote_value: -1)
      question.reload
      expect(question.vote_sum).to eq -1
    end
  end

  describe 'destroy vote' do

    let!(:vote) { create(:vote, votable: question, user: user) }

    before { vote.destroy }

    it 'delete vote' do
      question.reload
      expect(question.vote_sum).to eq 0
    end
  end
end
