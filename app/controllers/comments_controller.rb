class CommentsController < ApplicationController
  def create
    if @comment = Comment.create(comment_params)
      respond_to do |format|
        format.html{ redirect_to item_path(@comment.item.id) }
        format.json
      end
    else
      redirect_to item_path(@comment.item.id)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:message).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
