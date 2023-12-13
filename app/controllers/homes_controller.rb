class HomesController < ApplicationController
  before_action :authenticate_user!
  def top
  end

  def description
    # 説明ページの処理
  end
end
