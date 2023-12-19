class PastExamsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @past_exams = PastExam.all
    @past_exam = @past_exams.first
    if user_signed_in?
      # ユーザーがログインしている場合、past_scoreを取得
      @user_past_score = current_user.past_score
    end
  end

  def show
    @past_exam = PastExam.find(params[:id])
    @user_past_exam = UserPastExamAttempt.new(past_exam: @past_exam, user: current_user)
    #@past_exam.current_exam = @user_past_exam.past_exam
  end

  def answer
    @past_exam = PastExam.find(params[:id])
    selected_option = params.dig(:past_exam, :selected_option)

    # ここで回答の正誤判定や保存処理を行う
    is_correct = (@past_exam.correct_option == selected_option)

    # ユーザーの回答を保存
    user_attempt = current_user.user_past_exam_attempts.create!(
      past_exam: @past_exam,
      selected_option: selected_option,
      is_correct: is_correct,
      answered_at: Time.current
    )

    # 正解の場合、ユーザーのスコアを+1
    current_user.increment!(:score) if is_correct

    Rails.logger.info "Past Exam ID: #{@past_exam.id}, User Attempt ID: #{user_attempt.id}"

    # current_exam を取得
    current_exam = @past_exam

    # 次の問題があるかどうかを判定
    next_exam = @past_exam.next_exam(current_exam)

    if next_exam
      # 次の問題がある場合は、その問題を表示
      redirect_to past_exam_path(next_exam)
    else
      # 次の問題がない場合は、結果ページへ遷移
      redirect_to result_past_exam_path(@past_exam)
    end
  end

  def result
    @user = current_user
    @user_past_exam = @user.user_past_exam_attempts.where(past_exam: @past_exam)
    if current_user.present?
      # ユーザーがログインしている場合、scoreをpast_scoreにコピー
      current_user.update(past_score: current_user.score)
    end
  end  
end