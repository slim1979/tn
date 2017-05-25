class AnswersController < ApplicationController
  before_action :answer_params, only: :create
  def new
    @answer = Answer.new
  end

  def create
    @question = Question.find(params[:id])
    @answer = @question.answers.build(answer_params)
    @answer.save ? (redirect_to @question) : (render :new)
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
