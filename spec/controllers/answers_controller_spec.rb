require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer) { question.answers.create(body: '123') }

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
        expect { answer }.to change(Answer, :count).by(1)
      end

      it 'redirect to index view' do
        # answer
        post :new, params: { answer: attributes_for(:answer), id: question }
        expect(response).to redirect_to question_path(id: question)
        binding.pry

      end

    end

    context 'with invalid parameters' do
      it 'validate that incorrect answer will not be saved in db' do
        expect { post :new, params: { answer: attributes_for(:invalid_answer), id: question } }.to_not change(Answer, :count)
      end
      it 'validate re-rendering new view' do
        post :new, params: { answer: attributes_for(:invalid_answer)}
        expect(response).to render_template :new
      end

    end

  end
end
