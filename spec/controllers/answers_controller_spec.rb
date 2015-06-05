require 'rails_helper'

describe AnswersController do
  let!(:question) { create(:question) }
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

    context 'with valid attributes' do

      it 'it sets variable @answer  requested answer' do
        patch :update, question_id: question.id,
              id: answer, answer: attributes_for(:answer)
        expect(assigns(:answer)).to eq answer
      end

      it 'change answer attributes' do
        patch :update, question_id: question.id,
              id: answer, answer: {body: 'new body'}
        answer.reload
        expect(answer.body).to eq 'new body'
      end

      it 'redirect to  question show view' do
        patch :update, question_id: question.id,
              id: answer, answer: attributes_for(:answer)
        expect(response).to redirect_to question
      end
    end

    context 'with invalid attributes' do
      before { patch :update, question_id: question.id,
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
    before { answer }

    it 'it sets variable @answer  requested question' do

      delete :destroy, question_id: question.id,
             id: answer, answer: attributes_for(:answer)
      expect(assigns(:answer)).to eq answer
    end

    it 'delete answer' do
      expect { delete :destroy, question_id: question.id,
                      id: answer }.to change(Answer, :count).by(-1)
    end

    it 'redirect to questions#show view' do
      delete :destroy, question_id: question.id, id: answer
      expect(response).to redirect_to question
    end
  end
end

