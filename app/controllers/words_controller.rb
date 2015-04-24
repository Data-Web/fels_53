class WordsController < ApplicationController
	def index
		@categories = Category.all
		@words = Word.search_word params, current_user
	end
end
