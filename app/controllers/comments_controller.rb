class CommentsController < ApplicationController
  before_action :set_item, except: :destroy
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to item_path(@item)
    else
      render 'create'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to item_path(@comment.item.id)
    else
      render 'create'
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  end
  def set_item
    @item = Item.find(params[:item_id])
  end
end
