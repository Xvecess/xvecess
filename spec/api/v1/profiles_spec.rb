require 'rails_helper'

describe 'Profile API' do
  describe 'GET /me' do

    it_behaves_like 'API Authenticable'

    context 'unauthorized' do

      it 'returns 401 status if there is no access_token' do
        get '/api/v1/profiles/me', format: :json

        expect(response.status).to eq 401
      end

      it 'returns 401 status if  access_token is invalid' do
        get '/api/v1/profiles/me', format: :json, access_token: '1234'

        expect(response.status).to eq 401
      end
    end

    context 'authorized' do

      let(:me) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }

      before { get '/api/v1/profiles/me', format: :json, access_token: access_token.token }

      it 'returns 200 status' do
        expect(response).to be_success
      end

      %w(id email created_at updated_at status).each do |attr|
        it "contains #{attr}" do
          expect(response.body).to be_json_eql(me.send(attr.to_sym).to_json).at_path(attr)
        end
      end

      %w(password password_confirmation).each do |attr|

        it "does not contain #{attr}" do
          expect(response.body).to_not have_json_path(attr)
        end
      end
    end

    def do_request(options = {})
      get  '/api/v1/questions', { format: :json }.merge(options)
    end
  end

  describe 'GET /profiles' do

    it_behaves_like 'API Authenticable'

    context 'unauthorized' do

      it 'returns 401 status if there is no access_token' do
        get '/api/v1/profiles', format: :json

        expect(response.status).to eq 401
      end

      it 'returns 401 status if  access_token is invalid' do
        get '/api/v1/profiles', format: :json, access_token: '1234'

        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:me) { create(:user) }
      let!(:users) { create_list(:user, 2) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }

      before { get '/api/v1/profiles', format: :json, access_token: access_token.token }

      it 'returns 200 status' do
        expect(response).to be_success
      end

      it 'response contain users list' do
        expect(response.body).to be_json_eql(users.to_json).at_path('profiles')
      end

      %w(id email created_at updated_at status).each do |attr|
        it "contains #{attr}" do
          expect(response.body).to be_json_eql(users[0].send(attr.to_sym).to_json).
                                       at_path("profiles/0/#{attr}")
        end
      end

      %w(password password_confirmation).each do |attr|
        it "does not contain #{attr}" do
          expect(response.body).to_not have_json_path("0/#{attr}")
        end
      end
    end

    def do_request(options = {})
      get  '/api/v1/questions', { format: :json }.merge(options)
    end
  end
end