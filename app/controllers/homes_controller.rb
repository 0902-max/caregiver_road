class HomesController < ApplicationController
  before_action :authenticate_user!
  #before_action :redirect_after_sign_in
  def top
  end

  def description
    # 説明ページの処理
  end

  private

  def redirect_after_sign_in
    documents = current_user.documents
  
    if documents.exists?
      # ユーザーに関連づく書類が存在する場合はroot_pathにリダイレクト
      redirect_to root_path
    else
      # ユーザーに関連づく書類が存在しない場合はdescription_pathにリダイレクト
      redirect_to description_path
    end
  end
end
