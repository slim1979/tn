class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :load_question, only: %i[show edit update destroy]
  before_action :load_user, only: :create

  def index
    @questions = Question.all
  end

  def show; end

  def new
    @question = Question.new
  end

  def edit; end

  def create
    @question = @user.questions.build(question_params)

    if @question.save
      redirect_to questions_path, notice: 'Your question is successfully created!'
    else
      flash[:notice] = 'Title or body cant be blank. Try again'
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
    if @question.user_id == current_user.id
      @question.destroy
      redirect_to questions_path, notice: 'Deleted'
    else
      redirect_to questions_path, alert: 'Access denied'
    end
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def load_user
    @user = User.find(current_user.id)
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
