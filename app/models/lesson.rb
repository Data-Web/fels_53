class Lesson < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  delegate :fullname, to: :user
  delegate :name, to: :category, prefix: true

  scope :lesson_user, ->user {where("lessons.user_id IN
    (SELECT followed_id FROM relationships WHERE follower_id = '#{user.id}')
    OR lessons.user_id = '#{user.id}'")}
end