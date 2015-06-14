require 'rails_helper'

describe Answer do

  let (:user) { create(:user) }
  let (:question) { create(:question, user_id: user.id) }
  let (:answer) { create(:answer, user_id: user.id, question_id: question.id, best: false) }

  it { should validate_presence_of :body }

  it { should validate_presence_of :user_id }

  it { should validate_presence_of :question_id }

  it { should belong_to :question }

  it { should belong_to :user }

  it { should have_many(:attachments).dependent(:destroy) }

  it {should accept_nested_attributes_for :attachments}

  describe 'set best answer' do

    before { question.has_best_answer? }

    it 'question best answer true, answer set best' do
      answer.update(best: true)

      expect(answer.best).to be true
    end

    before { !question.has_best_answer? }

    it 'question best answer true, answer set best' do
      expect(answer.best).to be false
    end
  end

end
