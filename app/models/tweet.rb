class Tweet < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :text, presence: true, length: { maximum: 1500 }
  validates :title, presence: true, length: { maximum: 40 }

  # imageカラムに画像のurlを格納するよう指定
  mount_uploader :image, ImageUploader
end
