class FollowingsController < ApplicationController
  # POST /followings
  def create
    @following = Following.new(following_param)
    begin
      if @following.save
        redirect_to "/users"
      else
        redirect_to "/users", alert: "Unable to follow."
      end
    rescue ActiveRecord::RecordNotUnique
      redirect_to "/users", alert: "You are already following that person"
    end
  end

  # PATCH/PUT /followings
  def update
    @following = User.find(params[:following][:followed_users_id]).follow_requests.find_by(user_id: params[:following][:user_id])
    if params[:commit] == "Reject"
      if @following.update(following_param.merge({ status: "rejected" }))
        redirect_to "/users"
      else
        redirect_to "/users", alert: "Something went wrong."
      end
    elsif params[:commit] == "Allow"
      if @following.update(following_param.merge({ status: "approved" }))
        redirect_to "/users"
      else
        redirect_to "/users", alert: "Something went wrong."
      end
    end
  end

  private

  def following_param
    params.require(:following).permit(:user_id, :followed_users_id, :status)
  end
end
