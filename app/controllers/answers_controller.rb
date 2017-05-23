class AnswersController < ApplicationController

  def new
    @question = Question.find(params[:id])
    @answer = Answer.new(question_id: @question.id)
    redirect_to question_path(assigns(:question)) if @answer.save
  end

end
