class SearchesController < ApplicationController
  before_action :set_ransack

  def index
    # あいまい検索をした結果に[:q]がなければelseへ。
    if params[:q].present?
      @items = @q.result(distinct: true)
      # distinct: trueは取得するデータを重複させず、resultは送られてきたパラメーターに対して結果を受け取る
    else
      # @itemをsearch_searches_pathへ値を表示させる
      @items = Item.search(params[:search])
      @search = params[:search]
      # item.rbの'name LIKE(?)'で該当するデータを取得
      @q = @items.ransack(params[:q])
    end
  end

  def search
    # 詳細検索
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true)
  end

  private


  def set_ransack
    @q = Item.ransack(params[:q])
  end

end
