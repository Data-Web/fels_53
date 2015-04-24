class Word < ActiveRecord::Base
  belongs_to :categories
  has_many   :answers, dependent: :destroy
<<<<<<< HEAD

=======
  
>>>>>>> Admin manager: word and answer
  validates  :body, presence: true, uniqueness: true
  validates  :category_id, presence: true
  validate   :check_status

  accepts_nested_attributes_for :answers, allow_destroy: true
<<<<<<< HEAD

  private
=======
  scope :search_word, ->params,user {
    leanned  = "words.id IN (SELECT word_id FROM results WHERE lesson_id IN 
          (SELECT id FROM lessons WHERE user_id = #{user.id}))"
    notlean  = "words.id NOT IN (SELECT word_id FROM results WHERE lesson_id IN 
          (SELECT id FROM lessons WHERE user_id = #{user.id}))"
    category = "words.category_id = #{params[:category_id]}"

    if params[:category_id] != nil && params[:status].blank?
      joins(:answers).where(category)
        .select("words.body as word_name, answers.body as answer_name")
        .where("answers.status = 't'")

    elsif params[:category_id] != nil && params[:status] == 'leanned'
      joins(:answers)
        .where(category)
        .where(leanned)
        .select("words.body as word_name, answers.body as answer_name")
        .where("answers.status = 't'")

    elsif params[:category_id] != nil && params[:status] == 'notlean'
      joins(:answers)
        .where(category)
        .where(notlean)
        .select("words.body as word_name, answers.body as answer_name")
        .where("answers.status = 't'")

    elsif params[:category_id] != nil && params[:status] == 'all'
      joins(:answers).where(category)
        .select("words.body as word_name, answers.body as answer_name")
        .where("answers.status = 't'")
    else
      joins(:answers).select("words.body as word_name, answers.body as answer_name")
        .where("answers.status = 't'")
    end
  }

  private

>>>>>>> Admin manager: word and answer
  def check_status
    if answers.length < 2
      errors.add(:base, "Minimum 2 characters")
    elsif answers.select{|answer| answer.status}.count == 0  
      errors.add(:base, "Please select one correct answer")
    elsif answers.select{|answer| answer.status}.count > 1 
      errors.add(:base, "Only one correct answer is selected")
    end
  end
end
