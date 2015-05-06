class Lesson < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :results, dependent: :destroy
  
  delegate :fullname, to: :user
  delegate :name, to: :category, prefix: true

  scope :lesson_user, ->user {where("lessons.user_id IN
    (SELECT followed_id FROM relationships WHERE follower_id = '#{user.id}')
    OR lessons.user_id = '#{user.id}'")}
  

  accepts_nested_attributes_for :results, allow_destroy: true
  before_save :sum_correct

  private
  
  def sum_correct
    self.count_correct = results.select do |result|
      result.answer == result.answers.find_by(status: true)
    end.count
  end
end