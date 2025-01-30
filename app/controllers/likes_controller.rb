class LikesController < ApplicationController
  def new
    @like = Like.new
  end

  def create
    @like = Like.new(like_params)
    if params[:commit] == "Like!" && @like.save
      flash.now[:notice] = "Successfully liked!"
    else
      flash.now[:alert] = "Failed to like."
    end
  end

  def delete
    if params[:like][:likeable_type] == "Comment"
      @like = Comment.find(params[:like][:likeable_id]).likes.where(user_id: params[:like][:user_id]).first
    else
      @like = Post.find(params[:like][:likeable_id]).likes.where(user_id: params[:like][:user_id]).first
    end
    if params[:commit] == "Unlike!" && @like.destroy
      flash.now[:notice] = "Unliked Post"
    else
      flash.now[:alert] = "Unable to Unlike Post"
    end
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :likeable_type, :likeable_id)
  end
end
