class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.paginate page: params[:page], per_page: 10
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    if @user.update_attributes user_params 
      redirect_to @user
    else
      render "edit"
    end
  end
  
  def create
    @user = User.new user_params
    if @user.save 
      redirect_to @user
    else
      render "new"
    end
  end

  def show
    @user = User.find params[:id]
    @user_lessons = Lesson.lesson_user @user
    @activities = @user.activities
  end

  private
  
  def user_params
    params.require(:user).permit :fullname, :email, :password, :password_confirmation, :avatar
  end

  def correct_user
    @user = User.find params[:id]
    if @user != current_user && current_user.admin != true
      flash[:danger] = "You haven't permisson"
      redirect_to users_path
    end
  end
end