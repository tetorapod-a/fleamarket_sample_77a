class ItemsController < ApplicationController
  before_action :set_item, except: [:index, :new, :create]
  def index
    @items = Item.includes(:images).order(updated_at: "desc")
  end

  def new
    @item = Item.new
    @item.images.build
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path 
    else
      @item.images.build
      render :new
    end
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


  private

    def item_params
      params.require(:item).permit(:name, :detail, :price, :status_id, :postage_id, :shipping_day_id, :shipping_method_id, :prefecture_id, :brand, :category_id, :buyre_id, :seller_id, images_attributes: [:image, :id]).merge(seller_id: current_user.id)
    end

    def set_item
      @item = Item.find(params[:id])
    end
end
