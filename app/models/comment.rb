class Comment < ApplicationRecord
  belongs_to :tweet
  belongs_to :user

  validates :content, presence: true, length: { maximum: 1000 }
  # notifications-------------------------------------------------------------------
  has_many :notifications, dependent: :destroy
end
