class DocumentsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    # ログインユーザーに紐づく書類を取得
    @documents = current_user.documents
    Rails.logger.info("Current user's documents: #{@documents.inspect}")
  end

  def create
    choice_id = params[:choice_id]
    choice = Choice.find_by(id: choice_id)

    if choice
      case choice_id.to_i
      when 3, 4, 6
        create_documents_for_option_1(choice)
      when 5
        create_documents_for_option_2(choice)
      else
        redirect_to documents_path, alert: '選択された選択肢が見つかりませんでした。'
        return
      end

      redirect_to documents_path, notice: '書類が作成されました。'
    else
      redirect_to documents_path, alert: '選択された選択肢が見つかりませんでした。'
    end
  end

  private

  def create_documents_for_option_1(choice)
    # 選択肢が3, 4, 6の場合の書類作成ロジック
    document_names = [
      '受験申し込み票',
      '受験手数料払込証明書',
      '受験用写真等確認票',
      '卒業証明書'
    ]

    create_documents(choice, document_names)
  end

  def create_documents_for_option_2(choice)
    # 選択肢が5の場合の書類作成ロジック
    document_names = [
      '受験申し込み票',
      '受験手数料払込証明書',
      '受験用写真等確認票',
      '実務経験証明書',
      '従事日数内訳証明書',
      '実務者研修修了証明書'
    ]

    create_documents(choice, document_names)
  end

  def create_documents(choice, document_names)
    # 各書類を生成してログインユーザーに関連付ける
    document_names.each do |document_name|
      current_user.documents.create(
        choice: choice,
        document_name: document_name
      )
    end
  end
end
