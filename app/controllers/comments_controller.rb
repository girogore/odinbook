class CommentsController < ApplicationController
  def index
    @comments = Post.find(params[:post_id]).comments
  end

  def new
    @comment = Comment.new
    @is_comment = true
  end

  # POST /posts or /posts.json
  def create
    @comment = Comment.new(comment_params.merge({ post_id: params[:post_id] }))
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

  def destroy
    @comment = Comment.find(params.expect(:id))
    @comment.destroy!
    redirect_to "/", status: :see_other, notice: "Comment was successfully destroyed."
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :image, :user_id)
  end
end
