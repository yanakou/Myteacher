class Tweet < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  
  validates :user_id, presence: true
  validates :text, presence: true, length: { maximum: 1500 }
  validates :title, presence: true, length: { maximum: 40 }

  # 表示を降順にする
  default_scope -> { order(created_at: :desc) }
  
  # imageカラムに画像のurlを格納するよう指定
  mount_uploader :image, ImageUploader
end
