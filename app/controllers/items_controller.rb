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
    # カテゴリー編集
    # ▼ ①ここで該当商品の子・孫カテゴリーを変数へ代入
    # grandchild = @item.category
    # child = grandchild.parent
    # if @category_id == 46 or @category_id == 74 or @category_id == 134 or @category_id == 142 or @category_id == 147 or @category_id == 150 or @category_id == 158
    # else
    # ② ▼ 親カテゴリーのnameとidを配列代入
    #   @parent_array = []
    #   @parent_array << @item.category.parent.parent.name
    #   @parent_array << @item.category.parent.parent.id
    # end
    # ③ ▼ 子カテゴリーを全てインスタンス変数へ代入
    #   @category_children_array = Categorie.where(ancestry: child.ancestry)
    # ④ ▼ 子カテゴリーのnameとidを配列代入
    #   @child_array = []
    #   @child_array << child.name
    #   @child_array << child.id
    # ⑤ ▼ 孫カテゴリーを全てインスタンス変数へ代入
    #   @category_grandchildren_array = Categorie.where(ancestry: grandchild.ancestry)
    # ⑥ ▼ 孫カテゴリーのnameとidを配列代入
    #   @grandchild_array = []
    #   @grandchild_array << grandchild.name
    #   @grandchild_array << grandchild.id
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
      # ⑦ 該当の商品情報をインスタンス変数へ代入
    end

    # def category_parent_array
    #   @category_parent_array = Categorie.where(ancestry: nil)
    #   # ⑧ 親カテゴリーを全てインスタンス変数へ代入
    # end
end
