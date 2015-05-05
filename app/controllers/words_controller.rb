class WordsController < ApplicationController
  before_action :logged_in_user

  def index
    @categories = Category.all
    
    if %w(learned notlearn).include? params[:status]
      @words = Word.words_category(params[:category_id])
        .send(params[:status], current_user)
        .paginate page: params[:page], per_page: 10
    else
      @words = Word.words_category(params[:category_id])
        .paginate page: params[:page], per_page: 10
    end
  end
end