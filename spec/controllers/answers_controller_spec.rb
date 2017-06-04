# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }

  describe 'GET #new' do
    sign_in_user
    before { get :new, params: { question_id: question.id } }
    it 'assign a new answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end
    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    sign_in_user
    context 'with valid parametrs' do
      it 'validates that correct answer saves in db' do
        expect { post :create, params: { answer: attributes_for(:answer), question_id: question.id } }.to \
          change(Answer, :count)
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
        expect(response).to render_template :new
      end
    end
  end
end
