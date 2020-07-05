class SearchesController < ApplicationController
  def index
    # binding.pry
    @items = Item.search(params[:search]).limit(132)
    @search = params[:search]
  end
end
