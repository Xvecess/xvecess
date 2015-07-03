require 'rails_helper'

describe CommentsController do

  let(:user) { create(:user) }
  let(:question) { create(:question, user_id: user.id) }
  let!(:answer) { create(:answer, question_id: question.id, user_id: user.id, best: false) }
  let!(:comment) { create(:comment, commentable: question, user: user) }
  let!(:comment2) { create(:comment, commentable: answer, user: user) }

  describe 'POST #create' do
    sign_in_user

    context 'comment for question' do

      it 'should  create new comment for question ' do

        expect { post :create, question_id: question.id,
                      comment: attributes_for(:comment).merge(user: user),
                      format: :json }.to change(Comment, :count).by(1)
      end
    end

    context 'comment for answer' do

      it 'should  create new comment for answer ' do

        expect { post :create, answer_id: answer.id,
                      comment: attributes_for(:comment).merge(user: user),
                      format: :json }.to change(Comment, :count).by(1)
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user

    context 'comment for question' do

      before { comment.update!(user: @user) }

      it 'should  destroy comment for question ' do

        expect { delete :destroy, question_id: question.id, id: comment.id,
                        format: :json }.to change(Comment, :count).by(-1)
      end
    end

    context 'comment for answer' do

      before { comment2.update!(user: @user) }

      it 'should destroy comment for answer ' do

        expect { delete :destroy, answer_id: answer.id, id: comment2.id,
                        format: :json }.to change(Comment, :count).by(-1)
      end
    end
  end
end
