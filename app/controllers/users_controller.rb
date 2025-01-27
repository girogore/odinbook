class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @follow = current_user.followed_users
    @follow_request = current_user.follow_requests
  end
end
