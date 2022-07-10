class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params.merge(author: current_user))
    if @answer.save
      redirect_to question_path(@question), notice: 'Answer saved successfully'
    else
      render template: 'questions/show'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
