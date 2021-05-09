class Like < ApplicationRecord
  belongs_to :tweet
  belongs_to :user

  # 一つのツイートに一つのユーザーしかいいねができないように制限をかける
  validates :tweet_id, uniqueness: { scope: :user_id }
end
