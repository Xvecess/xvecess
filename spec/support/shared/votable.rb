shared_examples_for 'Votable' do

  it { should have_many(:votes).dependent(:destroy) }

  describe 'vote voted' do

    it 'create new vote with value 1' do
      parent.votes.create(user: user2, vote_value: 1)
      parent.reload
      expect(parent.vote_sum).to eq 1
    end

    it 'create new vote with value -1' do
      parent.votes.create(user: user2, vote_value: -1)
      parent.reload
      expect(parent.vote_sum).to eq -1
    end
  end

  describe 'destroy vote' do

    let!(:vote) { create(:vote, votable: parent, user: user) }

    before { vote.destroy }

    it 'delete vote' do
      parent.reload
      expect(parent.vote_sum).to eq 0
    end
  end
end