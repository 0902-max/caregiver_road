class QuestionsController < ApplicationController
  def index
    @current_question = Question.find(1)
    @choices = Choice.where(question_id: 1)
  end

  def get_next_question
    choice_id = params[:choice_id]

    # ここで選択肢に応じた処理を実装
    # 例: 選択肢が1の場合は質問IDが2の質問を取得
    if choice_id == '1'
      next_question_id = 2
    elsif choice_id == '2'
      next_question_id = 3
    end

    next_question = Question.find(next_question_id)
    choices = Choice.where(question_id: next_question_id)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace('question-container', partial: 'questions/question', locals: { question: next_question }),
          turbo_stream.replace('choices-container', partial: 'questions/choices', locals: { choices: choices })
        ]
      end
    end
  end
end