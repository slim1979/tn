# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question, user: @user) }
  let(:answer) { create(:answer, question: question, user: @user) }

  describe 'POST #create' do
    sign_in_user
    context 'with valid parametrs' do
      it 'validates that correct answer saves in db' do
        expect { post :create, params: { answer: attributes_for(:answer), question_id: question.id } }.to \
          change(Answer, :count).by(1)
      end

      it 'validates that created answer is linked with current user' do
        expect(answer.user_id).to eq @user.id
      end

      it 'redirect to question after save in db' do
        post :create, params: { question_id: question.id, answer: attributes_for(:answer), id: question }
        expect(response).to redirect_to question_path(id: question)
      end
    end

    context 'with invalid parametrs' do
      it 'validates that incorrect answer will not save in db' do
        expect { post :create, params: { question_id: question.id, answer: attributes_for(:invalid_answer), id: question } }.to_not \
          change(question.answers, :count)
      end
      it 're-render new template' do
        post :create, params: { question_id: question.id, answer: attributes_for(:invalid_answer), id: question }
        expect(response).to redirect_to question_path(id: question)
      end
    end
  end

  describe 'DELETE #destroy' do

    context 'Signed in user tries to delete answer' do
      sign_in_user
      it 'will change answers count' do
        answer
        expect{ delete :destroy, params:{ id: answer } }.to change(question.answers, :count).by(-1)
      end
      it 'will redirect to question path' do
        delete :destroy, params:{ id: answer }
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'non-author have no rights' do
      sign_in_user2
      it 'will not change answers count' do
        expect{ delete :destroy, params:{ id: answer } }.to_not change(question.answers, :count)
      end
    end
  end
end
