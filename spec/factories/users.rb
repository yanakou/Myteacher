FactoryBot.define do
  factory :user do
    name {'user'}
    email {'user@example.com'}
    password {'000000'}
    password_confirmation {'000000'}
    admin {true}
  end

  factory :user2, class: User do
    name {'user2'}
    email {'user2@example.com'}
    password {'000000'}
    password_confirmation {'000000'}
  end

  factory :users, class: User do
    sequence(:name){|n| "user_#{n}"}
    sequence(:email){|n| "user_#{n}@example.com"}
    password {'000000'}
    password_confirmation {'000000'}
  end

end