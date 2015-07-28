require 'rails_helper'

describe Ability do

  subject(:ability) { Ability.new(user) }

  describe 'quest user' do
    let(:user) { nil }

    it { should be_able_to :read, Question }
    it { should be_able_to :read, Answer }
    it { should be_able_to :read, Comment }
    it { should be_able_to :read, User }

    it { should_not be_able_to :manage, :all }
  end

  describe 'admin user' do
    let (:user) { create(:user, status: 99) }

    it { should be_able_to :manage, :all }
  end

  describe 'confirmed_user' do
    let(:user) { create(:user, status: 1) }
    let(:user2) { create(:user, status: 1) }
    let(:question) { create(:question, user: user) }
    let(:question2) { create(:question, user: user2) }
    let(:answer) { create(:answer, question: question, user: user) }
    let(:answer2) { create(:answer, question: question, user: user2) }
    let(:answer3) { create(:answer, question: question2, user: user2) }
    let(:comment) { create(:comment, user: user, commentable: question) }
    let(:comment2) { create(:comment, user: user2, commentable: question) }
    let(:authorization) { create(:authorization, uid: '12345', provider: 'facebook') }
    let(:attachment) { create(:attachment, attachable: question) }
    let(:attachment2) { create(:attachment,  attachable: question2) }
    let(:vote) { create(:vote, user: user, votable: question) }
    let(:vote2) { create(:vote, user: user2, votable: question) }


    it { should_not be_able_to :manage, :all }
    it { should be_able_to :read, Question }
    it { should be_able_to :read, Answer }
    it { should be_able_to :read, Comment }
    it { should be_able_to :read, User }

    it { should be_able_to :create, Authorization }
    it { should be_able_to :create, Question }
    it { should be_able_to :create, Answer }
    it { should be_able_to :create, Comment }
    it { should be_able_to :create, Attachment }
    it { should be_able_to :create, Vote }

    it { should be_able_to :update, question, user: user }
    it { should be_able_to :update, answer, user: user }
    it { should be_able_to :update, comment, user: user }
    it { should_not be_able_to :update, question2, user: user }
    it { should_not be_able_to :update, answer2, user: user }
    it { should_not be_able_to :update, comment2, user: user }

    it { should be_able_to :destroy, question, user: user }
    it { should be_able_to :destroy, answer, user: user }
    it { should be_able_to :destroy, comment, user: user }
    it { should_not be_able_to :destroy, question2, user: user }
    it { should_not be_able_to :destroy, answer2, user: user }
    it { should_not be_able_to :destroy, comment2, user: user }


    it { should be_able_to :vote_up, question2, user: user}
    it { should be_able_to :vote_up, answer2, user: user}
    it { should be_able_to :vote_down, question2, user: user}
    it { should be_able_to :vote_down, answer2, user: user}
    it { should be_able_to :destroy_vote, answer2, user: user}

    it { should_not be_able_to :vote_up, question, user: user}
    it { should_not be_able_to :vote_up, answer, user: user}
    it { should_not be_able_to :vote_down, question, user: user}
    it { should_not be_able_to :vote_down, answer, user: user}
    it { should_not be_able_to :destroy_vote, answer, user: user}

    it { should be_able_to :destroy, attachment,  user: user}
    it { should_not be_able_to :destroy, attachment2,  user: user}

    it { should be_able_to :best_answer, answer, user: user, best: false }
    it { should_not be_able_to :best_answer, answer3, user: user, best: false }
  end

end