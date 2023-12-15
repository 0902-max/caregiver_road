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

    @next_question = Question.find(next_question_id)
    @next_choices = Choice.where(question_id: next_question_id)

    render :index
  end
end