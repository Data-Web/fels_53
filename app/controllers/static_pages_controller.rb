class StaticPagesController < ApplicationController
  before_action :logged_in_user
  
  def home
    @user = User.find current_user
    @user_lessons = Lesson.lesson_user current_user
  end
end
