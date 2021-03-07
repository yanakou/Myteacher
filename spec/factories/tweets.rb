FactoryBot.define do
  factory :tweet do
    title { "MyString" }
    text { "MyText" }
    image { "MyString" }
    user { nil }
  end
end
