class ItemsController < ApplicationController
  before_action :set_item, except: [:index, :new, :create, :get_category_children, :get_category_grandchildren]
  before_action :category_parent_array, only: [:new, :create, :edit]

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
      @item.images.build
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
    @user = User.find(@item.seller_id)
    @parents = Categorie.where(ancestry:nil)
  end

  def edit
    # if user_signed_in?
      
    # else
    #   user_session_root_path
    # end
    @item = Item.find(params[:id])
  end

  def update
    if @item.update(item_params)
      redirect_to item_path notice: '更新しました'
    else
      render 'edit'
    end
  end

  def destroy
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

    def category_parent_array
      @category_parent_array = Categorie.where(ancestry: nil)        # ⑧ 親カテゴリーを全てインスタンス変数へ代入
    end

    # def show_all_instance
    #   @user = User.find(@item.user_id)
    #   @images = Image.where(item_id: params[:id])                   # ⑨ 該当商品の画像をインスタンス変数へ代入
    #   @images_first = Image.where(item_id: params[:id]).first
    #   @category_id = @item.category_id                              # ⑩ 該当商品のレコードからカテゴリーidを取得し、インスタンス変数へ代入（この際に取得するidは孫カテゴリーidです。）
    #   @category_parent = Categorie.find(@category_id).parent.parent                    
    #   @category_child = Categorie.find(@category_id).parent
    #   @category_grandchild = Categorie.find(@category_id)
    # end
end
