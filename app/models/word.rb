class Word < ActiveRecord::Base
  belongs_to :category
  has_many   :answers, dependent: :destroy

  validates  :body, presence: true, uniqueness: true
  validates  :category_id, presence: true
  validate   :check_status

  accepts_nested_attributes_for :answers, allow_destroy: true

  scope :learned, ->user {where("id IN (SELECT word_id FROM results
    WHERE lesson_id IN (SELECT id FROM lessons WHERE user_id = '#{user.id}'))")}

  scope :notlearn, ->user {where("id NOT IN (SELECT word_id FROM results
    WHERE lesson_id IN (SELECT id FROM lessons WHERE user_id = '#{user.id}'))")}

  scope :words_category, ->category_id {where category_id: category_id if category_id.present?}
  
  scope :random_words, ->user {Word.notlearn(user).order("random()").limit(20)}
  

  private

  def check_status
    if answers.length < 2
      errors.add :base, "Minimum 2 characters"
    elsif answers.select{|answer| answer.status}.count == 0  
      errors.add :base, "Please select one correct answer"
    elsif answers.select{|answer| answer.status}.count > 1 
      errors.add :base, "Only one correct answer is selected"
    end
  end
end