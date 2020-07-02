class CommentsController < ApplicationController
  before_action :set_item
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to item_path(id: @item.id)
    else
      render 'create'
    end
    # redirect_to "/items/#{comment.item.id}"
    # redirect_to root_path
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to item_path(id: @item.id)
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  end
  def set_item
    @item = Item.find(params[:item_id])
  end
end
