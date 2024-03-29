class PastExamsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @past_exams = PastExam.all
    if user_signed_in?
      # ユーザーがログインしている場合、past_scoreを取得
      @user_past_score = current_user.past_score
    end
    @incorrect_attempts = current_user.incorrect_attempts
    @past_exam_attempts = @incorrect_attempts.map(&:past_exam)
    # ランダムな PastExam を取得して @past_exam を設定
    @past_exam = @past_exams.sample
  end

  def show
    @past_exam = PastExam.find(params[:id])
    @user_past_exam = UserPastExamAttempt.new(past_exam: @past_exam, user: current_user)
    # セッションに問題数の進捗があれば取得、なければ初期化
    @question_count = session[:question_count] || 1
  end

  def answer
    @past_exam = PastExam.find(params[:id])
    selected_option = params.dig(:past_exam, :selected_option)

    # ここで回答の正誤判定や保存処理を行う
    is_correct = (@past_exam.correct_option == selected_option)

    previous_attempt = current_user.user_past_exam_attempts.find_by(past_exam: @past_exam)

    if previous_attempt
      # 以前の回答がある場合はそれを上書きして保存
      previous_attempt.update!(
        selected_option: selected_option,
        is_correct: is_correct, 
        answered_at: Time.current
      )
    else
      # 以前の回答がない場合は新しく作成して保存
      current_user.user_past_exam_attempts.create!(
        past_exam: @past_exam,
        selected_option: selected_option,
        is_correct: is_correct,
        answered_at: Time.current
      )
    end

    # 正解の場合、ユーザーのスコアを+1
    current_user.increment!(:score) if is_correct

    # current_exam を取得
    current_exam = @past_exam

    # セッションに問題数のカウントがあれば増やす、なければ初期化
    session[:question_count] ||= 1
    session[:question_count] += 1

    redirect_to explanation_past_exam_path(@past_exam)
  end

  def explanation
    @past_exam = PastExam.find(params[:id])
  
    # データベースから回答情報を取得
    @user_past_exam = current_user.user_past_exam_attempts.find_by(past_exam: @past_exam)
  
    if @user_past_exam
      # 回答情報が存在する場合、正解かどうかを判定
      @is_correct = @user_past_exam.is_correct
      @explanation = @past_exam.explanation
    else
      # 回答情報が存在しない場合
      @is_correct = false
      @explanation = 'まだ回答していません。'
    end
  end

  def next_question
    # ランダムな次の問題のIDを取得
    next_exam_id = PastExam.where.not(id: params[:id]).pluck(:id).sample
    if next_exam_id && session[:question_count] < 21
      # 次の問題がある場合は、問題数のカウントを増やしてその問題を表示
      redirect_to past_exam_path(next_exam_id)
    else
      # 次の問題がない場合または問題数が20問に達した場合は結果ページへ遷移
      session[:question_count] = nil  # 問題数のカウントをクリア
      redirect_to result_past_exam_path
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

  def retry_incorrect_answers
     # idの小さい順に12個ずつ表示するページネーション
    @incorrect_attempts = current_user.user_past_exam_attempts
    .where(is_correct: false)
    .includes(:past_exam)
    .order(id: :asc)
    .page(params[:page])
    .per(9)
    @user_past_exam = UserPastExamAttempt.new(user: current_user)

    # 以前の回答があればそれを取得して @user_past_exam にセット
    previous_attempt = @incorrect_attempts.find_by(past_exam: params[:id])
    if previous_attempt
      @user_past_exam.selected_option = previous_attempt.selected_option
    end
  end

  def retry_selected
    @past_exam = PastExam.find(params[:id])
    @user_past_exam = current_user.user_past_exam_attempts.find_by(past_exam: @past_exam, is_correct: false) || UserPastExamAttempt.new(user: current_user, past_exam: @past_exam)

    if request.post?
      selected_option = params.dig(:user_past_exam_attempt, :selected_option)
      is_correct = (@past_exam.correct_option == selected_option)

      @user_past_exam.update!(
        selected_option: selected_option,
        is_correct: is_correct,
        answered_at: Time.current
      )
      flash[:notice] = is_correct ? "正解です！" : "不正解です。"
      redirect_to retry_incorrect_answers_past_exam_path(@past_exam)
    end
  end
end