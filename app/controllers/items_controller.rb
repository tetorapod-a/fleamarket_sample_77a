class ItemsController < ApplicationController
  before_action :set_item, except: [:index, :new, :create]
  def index
  end

  def new
    @item = Item.new
    @item.images.build
  #   10.times do
  #     @item.images.build
  # end
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
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  # def item_params
  #   params.require(:item).permit(:name, :price, images_attributes: [:image, :_destroy, :id])
  # end

  # def set_item
  #   @item = Item.find(params[:id])
  # end  

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