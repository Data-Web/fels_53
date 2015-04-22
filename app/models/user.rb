class User < ActiveRecord::Base
  scope :by_user, -> id {where.not(id: id)}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :fullname, presence: true
  validates :email, confirmation: true, uniqueness: true, presence: true,
            format: {with: VALID_EMAIL_REGEX, message: "Email is invalid format"}
  validates :password, confirmation: true, presence: true, allow_blank: true
  validate  :upload_size

  has_secure_password
  mount_uploader :avatar, UploadUploader
  
  private
  def upload_size
    if avatar.size > 5.megabytes
      errors.add :avatar, "should be less than 5MB"
    end
  end
end
