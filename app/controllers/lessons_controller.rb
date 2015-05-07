class LessonsController < ApplicationController
  LIMITS = 20

  before_action :logged_in_user
  
  def index
    @user = User.find current_user
    @lessons = @user.lessons
  end

  def new
    @category = Category.find params[:category_id]
    @lesson = @category.lessons.build user_id: current_user.id
    @words = @category.words.random_words current_user
    
    if @words.count < LIMITS
      flash[:danger] = "Not enough 20 words"
      redirect_to categories_path
    else
      LIMITS.times do |n|
        @result = @lesson.results.build
        @result.word = @words[n]
      end
    end
  end

  def create    
    @category = Category.find params[:category_id]
    @lesson = @category.lessons.build lesson_params
    @lesson.user_id = current_user.id
    
    if @lesson.save
      redirect_to category_lesson_path  @category, @lesson, check: 1
    else
      flash[:danger] = "Error every where !"
      redirect_to :back
    end
  end

  def show
    @category = Category.find params[:category_id]
    @lesson = Lesson.find params[:id]
  end

  private

  def lesson_params
    params.require(:lesson).permit results_attributes: [:word_id, :answer_id]
  end
end