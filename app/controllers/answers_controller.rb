class AnswersController < ApplicationController

  def new
    if params[:id]
      @question = Question.find(params[:id])
      @answer = @question.answers.create(body: params[:body])
      redirect_to question_path(id: @question)
    else
    end
  end

end
