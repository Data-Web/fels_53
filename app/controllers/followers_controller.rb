class FollowersController < ApplicationController
  def index
    @title = "Follower"
    @user  = User.find params[:user_id]
    @users = @user.followers.paginate page: params[:page]
  end
end
