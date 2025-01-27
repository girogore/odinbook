class ProfilesController < ApplicationController
  before_action :verify_user, only: %i[ show edit update ]

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1
  def show
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  def create
    @profile = Profile.new(profile_param)
    if @profile.save
      redirect_to [ @user, @profile ], notice: "Profile was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /profiles/1
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

  def profile_param
    params.require(:profile).permit(:image)
  end

  def verify_user
    @user = User.find(params.expect(:user_id))
    @profile = User.find(params.expect(:user_id)).profile
  end
end
