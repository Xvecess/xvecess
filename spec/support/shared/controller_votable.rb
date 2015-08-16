shared_examples_for 'ControllerVotable' do

  describe 'PUT #vote_up' do
    sign_in_user

    it 'should answer vote sum increment' do
      put :vote_up, id: parent, format: :json
      parent.reload

      expect(parent.vote_sum).to eq 1
    end

    it 'should request question in json' do
      put :vote_up, id: parent, format: :json

      parent.reload
      expect(response.body).to include parent.to_json
    end
  end

  describe 'PUT #vote_down' do
    sign_in_user

    it 'should answer vote sum increment' do
      put :vote_down, id: parent, format: :json
      parent.reload

      expect(parent.vote_sum).to eq -1
    end

    it 'should request question in json' do
      put :vote_down, id: parent, format: :json

      parent.reload
      expect(response.body).to include parent.to_json
    end
  end

  describe 'DELETE #vote_down' do
    sign_in_user

    before do
      parent.votes.create(user: @user, votable: parent, vote_value: 1)
    end

    it 'should answer vote sum increment' do
      delete :destroy_vote, id: parent, format: :json
      parent.reload

      expect(parent.vote_sum).to eq 0
    end

    it 'should request question in json' do
      delete :destroy_vote, id: parent, format: :json
      parent.reload
      expect(response.body).to include parent.to_json
    end
  end


end