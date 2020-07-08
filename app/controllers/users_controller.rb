class UsersController < ApplicationController
  before_action :set_ransack


  def edit
  end

  def show
    @address = Address.find_by(user_id: current_user.id)
  end  

  def listing
    @items = Item.includes(:images).where(seller_id: current_user.id, buyer_id: nil).order(created_at: "desc")
  end

  def completed
    @items = Item.includes(:images).where(seller_id: current_user.id).where.not(buyer_id: nil)
  end

  def purchase
    @items = Item.includes(:images).where(buyer_id: current_user.id)
  end

  def like
  end

  def all_items
    @user = User.find(params[:id])
    @items = Item.includes(:images).where(seller_id: @user.id)
  end

  private

  def set_ransack
    @q = Item.ransack(params[:q])
  end

end