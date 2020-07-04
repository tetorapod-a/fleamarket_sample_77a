class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]

  def new
    @children = Categorie.find(params[:parent_id]).children
    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @items = @category.set_items
    @items = @items.order("created_at DESC")
  end

  private
  def set_category
    @category = Categorie.find(params[:id])
  end

end
