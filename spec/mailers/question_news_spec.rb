require "rails_helper"

describe QuestionNews do

  let(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }

  describe '#question update notification' do

    let(:email) { QuestionNews.question_update_notification(question, user).deliver_now }

    it 'should send email to user' do
      expect(email.to.first). to eq user.email
    end

    it 'should contains mail subject ' do
      expect(email.subject). to have_content 'Есть новые ответы'
    end

    it 'should contains update notification ' do
      expect(email.body). to have_content 'Вы подписаны на обновление'
    end
  end

end
