class ItemsController < ApplicationController

  def index
    # @items = Image.includes(:item).order(updated_at: "desc")
    @items = Item.includes(:image).order(updated_at: "desc")
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  
  def confirm
  end

end
