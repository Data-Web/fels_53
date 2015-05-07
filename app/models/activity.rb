class Activity < ActiveRecord::Base
  enum status: [:lesson, :follow, :unfollow]
  
  belongs_to :user

  validates :user_id, presence: true
  validates :target_id, presence: true

  def return_target_object
    lesson? ? Lesson.find(target_id) : User.find(target_id)
  end
end
