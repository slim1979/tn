# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }

  describe 'GET #new' do
    before { get :new }
    it 'assign a new question to @question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end
    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid parametrs' do
      it 'validates that correct answer saves in db' do
        expect { post :create, params: { answer: attributes_for(:answer), id: question } }.to change(question.answers, :count).by(1)
      end
      it 'redirect to question after save in db' do
        post :create, params: { answer: attributes_for(:answer), id: question }
        expect(response).to redirect_to question_path(id: question)
      end
    end
  end
end
