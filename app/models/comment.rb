class Comment < ApplicationRecord
  belongs_to :tweet
  belongs_to :user

  validates :content, presence: true
  # notifications-------------------------------------------------------------------
  has_many :notifications, dependent: :destroy
  
end
