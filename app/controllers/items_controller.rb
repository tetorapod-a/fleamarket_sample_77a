class ItemsController < ApplicationController
  before_action :set_item, except: [:index, :new, :create, :get_category_children, :get_category_grandchildren]
  before_action :category_parent_array, only: [:new, :create, :edit]
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :set_ransack

  def index
    @items = Item.includes(:images).order(created_at: "desc")
    @item = @items.where(category_id: 131)
    @parents = Categorie.where(ancestry: nil)

  end

  def new
    if user_signed_in?
      @item = Item.new
      @item.images.build
    else
      redirect_to user_session_path
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
    @img = Image.where(item_id: @item).drop(1)
    @items = Item.includes(:images)
    @image = @items.where(category_id: @item.category_id)
    @category = Categorie.find(@item.category_id)
    @user = User.find(@item.seller_id)
    @parents = Categorie.where(ancestry:nil)
    @comment = Comment.new
    @comments = @item.comments.includes(:user)
  end

  def edit
    unless @item.buyer_id == nil
      redirect_to item_path(@item)
    end
    if current_user.id != @item.seller_id
      redirect_to item_path
    else
      render 'edit'
    end
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
    @category_children = Categorie.where('ancestry = ?', "#{params[:parent_name]}")
  end

  def get_category_grandchildren
    @category_grandchildren = Categorie.where('ancestry LIKE ?', "%/#{params[:child_id]}")
  end

  private

  def item_params
    params.require(:item).permit(:name, :detail, :price, :status_id, :postage_id, :shipping_day_id, :shipping_method_id, :prefecture_id, :brand, :category_id, :buyre_id, :seller_id, images_attributes: [:image, :_destroy, :id]).merge(seller_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def category_parent_array
    @category_parent_array = Categorie.where(ancestry: nil) 
  end

  def set_ransack
    @q = Item.ransack(params[:q])
  end
end
