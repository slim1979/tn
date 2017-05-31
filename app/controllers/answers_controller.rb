class AnswersController < ApplicationController
  before_action :answer_params, only: :create
  def new
    @answer = Answer.new
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    if @answer.save
      redirect_to question_path(id: params[:question_id]), notice: 'Thank your for your answer!'
    else
      render :new
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
