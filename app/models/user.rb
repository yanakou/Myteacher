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

  # likeモデルと関連付け
  has_many :likes
  
  #tweetsと関連付け
  has_many :tweets, dependent: :destroy

  has_many :comments

  # DM機能----------------------------------------------------------------------------
  has_many :messages
  has_many :entries
  has_many :rooms, through: :entries

  # フォロー機能---------------------------------------------------------------------------------
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship"
  has_many :following, through: :following_relationships
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship"
  has_many :followers, through: :follower_relationships

  #フォローしているかを確認するメソッド
  def following?(user)
    following_relationships.find_by(following_id: user.id)
  end

  #フォローするときのメソッド
  def follow(user)
    following_relationships.create!(following_id: user.id)
  end

  #フォローを外すときのメソッド
  def unfollow(user)
    following_relationships.find_by(following_id: user.id).destroy
  end

  # notifications-------------------------------------------------------------------
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id'
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id'
end
