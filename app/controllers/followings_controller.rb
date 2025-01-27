class FollowingsController < ApplicationController
  # POST /followings
  def create
    @following = Following.new(following_param)
    if @following.save
      redirect_to "/users"
    else
      redirect_to "/users", alert: "Unable to follow."
    end
  end

  # PATCH/PUT /followings
  def update
    if params[:profile].nil?
      redirect_to [ @user, @profile ], notice: "No changes performed."
    else
      if @profile.update(profile_param)
        @profile.image_derivatives!
        redirect_to [ @user, @profile ], notice: "Profile picture was successfully updated."
      else
        Shrine.plugin :remove_invalid
        flash.now[:alert] = "Image wrong type or too big"
        render :edit, status: :unprocessable_entity
      end
    end
  end

  private

  def following_param
    params.require(:following).permit(:user_id, :followed_users_id, :status)
  end
end
