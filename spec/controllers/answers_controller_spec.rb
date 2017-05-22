require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer) { question.answers.create }

  describe 'user can aswer on question' do

    context 'with valid parameters' do

      it 'validates the question is exist' do
        expect(:question).to_not eq nil
      end

      it 'validates the answer is not blank' do
        get :new, params: {id: question}
        expect(assigns(:answer)).to be_a_new(Answer)
        expect(assigns(:answer)).to_not be_blank
      end

      it 'equal question id with answer question_id' do
        expect(question.id).to eq answer.question_id
      end

      it 'validate that correct answer saves in db' do
        expect { question.answers.create(body: 'some body') }.to change(Answer, :count).by(1)
      end

      it 'redirect to index view' do
        post :new, params: { answer: attributes_for(:answer), id: question }
        expect(response).to redirect_to question_path(id: question)
      end

    end

    context 'with invalid parameters' do
      it '' do
        post :new, params: { answer: attributes_for(:answer), id: question }

      end
    end
  end
end
