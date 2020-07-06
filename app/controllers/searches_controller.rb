class SearchesController < ApplicationController
  before_action :set_ransack

  def index
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true)
  end

  def detail_search
    @search_item = Item.ransack(params[:q]) 
    @items = @search_item.result.page(params[:page])
  end

  private


  def set_ransack
    @q = Item.ransack(params[:q])
  end

end
