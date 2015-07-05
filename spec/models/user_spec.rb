require 'rails_helper'

describe User do

  it { should have_many(:answers) }

  it { should have_many(:questions) }

  it { should have_many(:votes).dependent(:destroy) }

  it { should have_many(:comments) }

  describe 'find user voted? by votable' do

    let(:user) { create(:user) }
    let(:user2) { create(:user) }
    let(:question) { create(:question, user: user) }
    let!(:vote) { create(:vote, votable: question, user: user, vote_value: 1) }

    it 'should return true if user voted' do
      expect(user.voted?(question)).to eq true
    end

    it 'should return false if user not voted' do
      expect(user2.voted?(question)).to eq false
    end
  end
end
