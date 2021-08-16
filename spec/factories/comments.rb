FactoryBot.define do
  factory :comment do
    association :tweet
    user { tweet.user }
    content { Faker::Lorem.word }
  end

  factory :comment1, class: Comment do
    user_id { FactoryBot.create(:user).id }
    tweet_id { FactoryBot.create(:tweet).id }
    content { Faker::Lorem.word }
  end
end
