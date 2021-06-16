class Like < ApplicationRecord
  # users-----------------------------------------------------------------------------
  belongs_to :user
  # tweets---------------------------------------------------------------------------
  belongs_to :tweet, counter_cache: :likes_count
  # likes-------------------------------------------------------------------------------
  validates :tweet_id, uniqueness: { scope: :user_id }, presence: true # 一つのツイートに一つのユーザーしかいいねができないように制限をかける
  validates :user_id, presence: true
end
