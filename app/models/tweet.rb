class Tweet < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  validates :user_id, presence: true
  validates :text, presence: true, length: { maximum: 1500 }
  validates :title, presence: true, length: { maximum: 40 }

  # 表示を降順にする
  default_scope -> { order(created_at: :desc) }
  
  # imageカラムに画像のurlを格納するよう指定
  mount_uploader :image, ImageUploader

  #既にいいねしているか確認するメソッド
  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end

  # search-------------------------------------------------------------------
  def self.search(search)
    if search
      Tweet.where('title Like(?) OR text Like(?)', "%#{search}%", "%#{search}%")
    else
      Tweet.all
    end
  end
  
  # ActAsTaggable-------------------------------------------------------------------
  acts_as_taggable
end
