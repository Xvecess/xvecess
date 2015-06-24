require 'rails_helper'

describe Vote do
  let(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:question) { create(:question, user: user, vote_sum: 2) }
  let!(:vote) { create(:vote, user: user2, votable: question, vote_value: 1) }

  it { should belong_to :votable }

  it { should validate_presence_of :user_id }

  it { should validate_presence_of :votable_id }

  it { should validate_presence_of :votable_type }

  it { should validate_presence_of :vote_value }


  describe 'after destroy vote' do
    before do
      vote.destroy
    end
    it 'change vote sum for votable' do
      expect(question.reload.vote_sum).to eq 0
    end
  end
end
