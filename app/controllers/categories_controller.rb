class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]
  before_action :set_ransack

  def new
    @children = Category.find(params[:parent_id]).children
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
    @category = Category.find(params[:id])
  end

  def set_ransack
    @q = Item.ransack(params[:q])
  end
end
