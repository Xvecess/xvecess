require 'rails_helper'

describe AnswersController do

  let(:user) { create(:user)}
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question_id: question.id) }

  describe 'GET #new' do
    sign_in_user

    before { get :new, question_id: question.id }

    it 'it sets variable @question  requested question' do
      expect(assigns(:question)).to eq question
    end

    it 'assigns @answer to be a new answer' do
      expect(assigns(:answer)).to be_a_new (Answer)
    end

    it 'render new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    sign_in_user
    context ' create answer with valid attributes' do

      it 'the answer belong to question and saving in database' do
        expect { post :create, question_id: question.id, answer: attributes_for(:answer) }
            .to change(question.answers, :count).by(1)
      end

      it 'redirect to question#show view' do
        post :create, question_id: question.id, answer: attributes_for(:answer)
        expect(response).to redirect_to question
      end
    end

    context 'create answer with invalid attributes' do

      it 'try save new question, but not save' do
        expect { post :create, question_id: question.id, answer: attributes_for(:invalid_answer) }
            .to_not change(Answer, :count)
      end

      it 're render new view' do
        post :create, question_id: question.id, answer: attributes_for(:invalid_answer)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    sign_in_user

    before { answer.update!(user: @user) }

    context 'with valid attributes' do

      before { answer.user = user }

      it 'not change answer, If user is not the owner answer' do
        patch :update,
              id: answer, answer: attributes_for(:answer)
        expect(answer.body).to eq 'MyAnswer'
      end


      it 'change answer attributes' do
        patch :update, id: answer, answer: {body: 'new body'}
        answer.reload
        expect(answer.body).to eq 'new body'
      end

      it 'redirect to  question show view' do
        patch :update,
              id: answer, answer: attributes_for(:answer)
        expect(response).to redirect_to question
      end
    end

    context 'with invalid attributes' do

      before { patch :update,
                     id: answer, answer: {body: nil} }

      it 'do not change answer' do
        expect(answer.body).to eq 'MyAnswer'
      end

      it 're-render edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user

    context 'with owner user' do

      before { answer.update!(user: @user) }

      it 'delete answer' do
        expect { delete :destroy,
                        id: answer }.to change(Answer, :count).by(-1)
      end

      it 'redirect to questions#show view' do
        delete :destroy, id: answer
        expect(response).to redirect_to question
      end
    end

    context 'user not owner answer' do

      it 'not destroy answer, If user is not the owner answer' do
        expect { delete :destroy,
                        id: answer }.to change(Answer, :count).by(0)
      end
    end

  end
end

