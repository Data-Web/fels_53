class StaticPagesController < ApplicationController
  def home
    @user = User.find current_user
  end
end
