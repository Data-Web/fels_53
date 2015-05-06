class Result < ActiveRecord::Base
  belongs_to :word
  belongs_to :answer
  
  delegate :answers, to: :word
end