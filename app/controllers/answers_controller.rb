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
    @answer.update user_id: @user.id
    # binding.pry

    if @answer.save
      redirect_to @question
    else
      render :new
    end
  end

  def destroy
    if @answer.user_id == current_user.id
      @answer.destroy
      redirect_to question_path(id: @answer.question_id)
    else
      redirect_to question_path(id: @answer.question_id), alert: 'Не твое! Не трожь!'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body, :user_id)
  end

  def pull_question
    @user = current_user
    @question = Question.find(params[:question_id])
  end

  def pull_answer
    @answer = Answer.find(params[:id])
  end
end
