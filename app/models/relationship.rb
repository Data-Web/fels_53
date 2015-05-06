class Relationship < ActiveRecord::Base
  include ActivityLogs

  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  
  validates :follower_id, presence: true
  validates :followed_id, presence: true

  after_save :follow_activity
  before_destroy :unfollow_activity

  private

  def follow_activity
    create_activity follower_id, followed_id , "follow"
  end

  def unfollow_activity
    create_activity follower_id, followed_id , "unfollow"
  end
end