class LikesController < ApplicationController
  def new
    @like = Like.new
  end

  def create
    @like = Like.new(like_params)
    if @comment.body.empty? && (@comment.image_data.nil? || @comment.image_data.empty?)
      flash.now[:alert] = "Your comment is empty"
      return
    end
    respond_to do |format|
      if @comment.save
        Post.find(params[:post_id].to_i).comments << @comment
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def like_params
    params.require(:like).expect(:user_id, :likeable_type, :likeable_id)
  end
end
