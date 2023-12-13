class GrantsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    # 検索フォームからのキーワード取得
    keyword = params[:keyword]

    # API エンドポイント
    api_url = 'https://api.jgrants-portal.go.jp/exp/v1/public/subsidies'

    # クエリパラメータ
    query_params = {
      keyword: keyword,
      sort: 'created_date',
      order: 'DESC',
      acceptance: 1,
      page: params[:page] || 1, # ページ番号の取得
      per_page: 10 # 1ページあたりのアイテム数
    }

    # Faraday セットアップ
    conn = Faraday.new(url: api_url) do |faraday|
      faraday.adapter Faraday.default_adapter
    end

    # GET リクエスト送信
    response = conn.get do |req|
      req.url '', query_params
      req.headers['Accept'] = 'application/json'
    end

    # レスポンスの処理
    if response.success?
      data = JSON.parse(response.body)
      @count = data['metadata']['resultset']['count']

      # 8件以上の場合のみページネーションを有効にする
      @grants = if @count > 8
                  Kaminari.paginate_array(data['result'], total_count: @count)
                          .page(params[:page])
                          .per(8)
                else
                  data['result']
                end
    else
      @error = "Error: #{response.status}"
    end
  end
end


