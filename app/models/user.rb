class User < ActiveRecord::Base
  attr_accessor :remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :fullname, presence: true
  validates :email, confirmation: true, uniqueness: true, presence: true,
    format: {with: VALID_EMAIL_REGEX, message: "Email is invalid format"}
  validates :password, confirmation: true, presence: true, allow_blank: true
  validate  :upload_size

  has_secure_password
  mount_uploader :avatar, UploadUploader
  
  def User.digest string
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attributes! remember_digest: User.digest(remember_token)
  end

  def authenticated? remember_token
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attributes! remember_digest: nil
  end

  private
  
  def upload_size
    if avatar.size > 5.megabytes
      errors.add :avatar, "should be less than 5MB"
    end
  end
end
