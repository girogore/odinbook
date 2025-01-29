class PostsController < ApplicationController
  before_action :set_post, only: %i[ show destroy ]
  before_action :authenticate_user!

  # GET /posts or /posts.json
  def index
    @posts = current_user.posts
    current_user.following.each do |following|
      if following.status == "approved"
        @posts += (User.find(following.followed_users_id.to_i).posts)
      end
    end
    @posts = @posts.sort_by { |post| post.created_at }
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
    @is_comment = false
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    if @post.body.empty? && (@post.image_data.nil? || @post.image_data.empty?)
      flash.now[:alert] = "Your post is empty"
      return
    end
    respond_to do |format|
      if @post.save
        User.find(params[:post][:user_id].to_i).posts << @post
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!
    redirect_to posts_path, status: :see_other, notice: "Post was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:body, :image, :user_id)
    end
end
