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

  describe '.find_for_oauth' do

    let!(:user) { create(:user) }
    let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456') }

    context 'user already has authentication' do
      it 'returns the user' do
        user.authorizations.create(provider: 'facebook', uid: '123456')
        expect(User.find_for_oauth(auth)).to eq user
      end
    end

    context 'user has not authorization' do

      context 'user alredy exist' do

        let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456',
                                            info: {email: user.email}) }
        it 'does not create new user' do
          expect { User.find_for_oauth(auth) }.to_not change(User, :count)
        end

        it 'creates authorizations for user' do
          expect { User.find_for_oauth(auth) }.to change(user.authorizations, :count).by(1)
        end

        it 'creates authorizations with provider and uid ' do
          authorization = User.find_for_oauth(auth).authorizations.first

          expect(authorization.provider).to eq auth.provider
          expect(authorization.uid).to eq auth.uid
        end

        it 'returns the user' do
          expect(User.find_for_oauth(auth)).to eq user
        end
      end
    end

    context 'user does not exist ' do
      let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456',
                                          info: {email: 'new@user.com'}) }

      it 'creates new user' do
        expect { User.find_for_oauth(auth) }.to change(User, :count).by(1)
      end

      it 'returns new user' do
        expect(User.find_for_oauth(auth)).to be_a(User)
      end

      it 'fills user email' do
        user = User.find_for_oauth(auth)
        expect(user.email).to eq auth.info.email
      end

      it 'creates authorization for user' do
        user = User.find_for_oauth(auth)
        expect(user.authorizations).to_not be_empty
      end

      it 'creates authorization with provider and uid' do
        authorization = User.find_for_oauth(auth).authorizations.first

        expect(authorization.provider).to eq auth.provider
        expect(authorization.uid).to eq auth.uid
      end
    end
  end

  describe '.send daily mailer' do
    let!(:users) { create_list(:user, 3) }

    it 'send daily mailer for all users' do
      users.each do |user|
        expect(DailyMailer).to receive(:daily_digest).with(user).and_call_original
      end
      User.send_daily_digest
    end
  end
end
