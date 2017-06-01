class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :load_question, only: %i[show edit update destroy]
  # before_action :load_answers, only: %i[show edit update destroy]

  def index
    @questions = Question.all
  end

  def show; end

  def new
    @question = Question.new
  end

  def edit; end

  def create
    @user = User.find(params[:user_id])
    @question = @user.questions.build(question_params)
    if @question.save
      redirect_to questions_path, notice: 'Your question is successfully created!'
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    @question.answers.destroy
    redirect_to questions_path
  end

  private

  def load_question
    @question = Question.find(params[:id])
    @answer = Answer.where question_id: @question.id
  end

  # def load_answers
  #   @question = Question.find(params[:id])
  # end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
