require 'rails_helper'

describe AttachmentsController do

  let(:user) { create(:user) }
  let(:question) { create(:question, user_id: user.id) }
  let!(:answer) { create(:answer, question_id: question.id, user_id: user.id, best: false) }
  let!(:attachment) { create(:attachment, attachable_id: answer.id, attachable_type: answer) }

  describe 'DELETE #destroy' do
    sign_in_user

    it 'delete attachment' do

      expect { delete :destroy,
                      id: attachment, format: :js }.to change(Attachment, :count).by(-1)
    end
  end
end
