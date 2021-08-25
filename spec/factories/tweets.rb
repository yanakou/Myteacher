FactoryBot.define do
  factory :tweet do
    title         { Faker::Lorem.word }
    text          { Faker::Lorem.word }
    image         { File.open("#{Rails.root}/app/assets/images/default.png") }
    created_at    { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
    # user
    association :user
  end

  factory :tweet1, class: Tweet do
    title         { 'tweet1' }
    text          { 'tweet1を投稿します' }
    image         { File.open("#{Rails.root}/app/assets/images/default.png") }
    created_at    { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
    # user
    association :user, factory: :user2
  end

  factory :tweet2, class: Tweet do
    title         { 'tweet2' }
    text          { 'tweet2を投稿します' }
    image         { File.open("#{Rails.root}/app/assets/images/default.png") }
    created_at    { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
    # user
    association :user, factory: :user3
  end
end
