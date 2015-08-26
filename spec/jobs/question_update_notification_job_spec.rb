require 'rails_helper'

describe QuestionUpdateNotificationJob do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:subscribe) { create(:subscribe, question: question, user: user) }
  let(:subscribe2) { create(:subscribe, question: question, user: user2) }

  it 'job send notification from subscribed users' do
    question.subscribed_users.find_each do |u|
      expect(QuestionNews).to receive(:question_update_notification).with(u)
    end
    QuestionUpdateNotificationJob.perform_now(question)
  end
end
