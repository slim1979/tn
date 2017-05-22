class AnswersController < ApplicationController
  def index
  end

  def create
    # @answer = question.answers.create(body: params[:body])
  end

  def new
    question = Question.find(params[:id])
    @answer = Answer.new(question_id: question.id)
    @answer.save
    redirect_to question_path(id: question)    
  end

  def show; end
end
