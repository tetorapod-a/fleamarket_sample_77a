class ItemsController < ApplicationController
  before_action :set_item, except: [:index, :new, :create, :get_category_children, :get_category_grandchildren]

  def index
    @items = Item.includes(:images).order(updated_at: "desc")
    @item = @items.where(category_id: 131)
  end

  def new
    @item = Item.new
    @item.images.build
    @category_parent_array = ["---"]
    Categorie.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path 
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
    @user = User.find(@item.seller_id)
    @parents = Categorie.where(ancestry:nil)
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path notice: '更新しました'
    else
      render 'edit'
    end
  end

  def destroy
    @item = Item.find(params[:id])
    if @item.destroy
      redirect_to root_path notice: '出品を取り消しました'
    else
      redirect_to item_path
    end
  end

  def confirm
  end

  def get_category_children
    @category_children = Categorie.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def get_category_grandchildren
    @category_grandchildren = Categorie.find("#{params[:child_id]}").children
  end

  private

    def item_params
      params.require(:item).permit(:name, :detail, :price, :status_id, :postage_id, :shipping_day_id, :shipping_method_id, :prefecture_id, :brand, :category_id, :buyre_id, :seller_id, images_attributes: [:image, :_destroy, :id]).merge(seller_id: current_user.id)
    end

    def set_item
      @item = Item.find(params[:id])
    end
end
