require 'rails_helper'

describe Question do
  let(:question) { create(:question) }
  let!(:answers) { question.answers.create(body: 'Test text') }

  it { should validate_presence_of :title }

  it { should validate_presence_of :body }

  it { should have_many :answers }

  describe 'check depend:destroy association' do
    it 'destroy all answers for question' do
      expect { question.destroy }.to change { question.answers.count }.by(-1)
    end
  end
end