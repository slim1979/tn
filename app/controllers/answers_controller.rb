class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :answer_params, only: :create

  def new
    @answer = @question.answer.new
  end

  def create
    @question = @user.question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    if @answer.save
      redirect_to question_path(id: params[:question_id]), notice: 'Thank your for your answer!'
    else
      render :new
    end
  end

  def destroy
    @answer = Answer.find(params[:id]).destroy
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
