class Answer < ActiveRecord::Base
  belongs_to :word
  
  scope :correct, -> {where status: true}

  validates :body, presence: true
end
