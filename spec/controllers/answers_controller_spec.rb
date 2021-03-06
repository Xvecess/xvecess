require 'rails_helper'

describe AnswersController do

  let!(:user) { create(:user, status: 1) }
  let(:question) { create(:question, user_id: user.id) }
  let!(:answer) { create(:answer, question_id: question.id, user_id: user.id) }
  let!(:answer2) { create(:answer, question_id: question.id, user_id: user.id) }

  describe 'POST #create' do
    sign_in_user

    context ' create answer with valid attributes' do

      it 'the answer belong to question and saving in database' do
        expect { post :create, question_id: question.id,
                      answer: attributes_for(:answer), format: :js }
            .to change(question.answers, :count).by(1)
      end

      it 'answer user is the current user' do
        post :create, question_id: question.id,
             answer: attributes_for(:answer), format: :js
        expect(assigns(:answer).user).to eq subject.current_user
      end
    end

    context 'create answer with invalid attributes' do

      it 'try save new question, but not save' do
        expect { post :create, question_id: question.id,
                      answer: attributes_for(:invalid_answer), format: :js }
            .to_not change(Answer, :count)
      end
    end
  end

  describe 'PATCH #update' do
    sign_in_user

    before { answer.update!(user: @user) }

    context 'with valid attributes' do

      it 'change answer attributes' do
        patch :update, id: answer, format: :js, answer: {body: 'new body'}
        answer.reload
        expect(answer.body).to eq 'new body'
      end
    end

    context 'with invalid attributes' do

      before { patch :update,
                     id: answer, format: :js, answer: {body: nil} }

      it 'do not change answer' do
        expect(answer.body).to eq 'MyAnswer'
      end
    end

    context 'user not owner answer' do

      before { answer.user = user }

      it 'not change answer, If user is not the owner answer' do
        patch :update,
              id: answer, format: :js, answer: attributes_for(:answer)
        expect(answer.body).to eq 'MyAnswer'
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user

    context 'with owner user' do

      before { answer.update!(user: @user) }

      it 'delete answer' do
        expect { delete :destroy,
                        id: answer, format: :js }.to change(Answer, :count).by(-1)
      end
    end

    context 'user not owner answer' do

      before { answer.user = user }

      it 'not destroy answer, If user is not the owner answer' do
        expect { delete :destroy,
                        id: answer, format: :js }.to_not change(Answer, :count)
      end

      it 'it redirect to if answer not  destroy' do
        delete :destroy, id: answer, format: :js
        expect(response).to redirect_to root_url
      end
    end
  end

  describe 'POST #best_answer' do
    sign_in_user

    context 'with  best equal false' do

      before  do
        question.update!(user: @user)
         answer.update!(best: false)
      end

      it 'sets answer best on true' do
        post :best_answer, id: answer
        answer.reload
        expect(answer.best).to be true
      end

      it 'redirect answer.question view' do
        post :best_answer, id: answer
        expect(response).to redirect_to question_path(answer.question)
      end
    end
    context 'with best equal true' do

      before  do
        question.update!(user: @user)
        answer.update!(best: true)
      end

      it 'sets answer best on true' do
        post :best_answer, id: answer2
        answer.reload
        expect(answer.best).to be false
      end
    end
  end

  let(:parent) { answer }
  it_behaves_like 'ControllerVotable'

end