class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
                                    format: { with: VALID_EMAIL_REGEX },
                                    uniqueness: {case_sensitive: true}

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # avaterカラムに画像のurlを格納するよう指定
  mount_uploader :avatar, AvatarUploader

  #tweetsと関連付け
  has_many :tweets, dependent: :destroy

  has_many :tweets
  has_many :comments
end
