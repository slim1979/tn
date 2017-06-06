class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :pull_question, only: %i[new create]
  before_action :pull_answer, only: :destroy
  before_action :answer_params, only: :create

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.build(answer_params)
    @answer.update user_id: current_user.id
    if @answer.save
      redirect_to @question
    else
      redirect_to @question
    end
  end

  def destroy
    @answer = @question.answers.find(params[:id])
    if @answer.user_id == current_user.id
      @answer.destroy
      redirect_to question_path(@question), notice: 'Deleted'
    else
      redirect_to question_path(@question), alert: 'Access denied'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def pull_question
    @question = Question.find(params[:question_id])
  end

  def pull_answer
    @answer = Answer.find(params[:id])
    @question = Question.find(@answer.question.id)

  end

end
