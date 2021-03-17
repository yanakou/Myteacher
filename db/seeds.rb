# メインのサンプルユーザーを1人作成する
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

# 追加のユーザーをまとめて生成する
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

# tweetを作成
Tweet.create!(title:  "Hello",
             text: "I'm feeling good!!",
             image: File.open('./app/assets/images/camera.jpeg'),
             user_id: 1)

30.times do |n|
  title  = Faker::Lorem.sentence(word_count: 2)
  text = Faker::Lorem.sentence(word_count: 5)
  image =  File.open('./app/assets/images/camera.jpeg')
  user_id = n+1
  Tweet.create!(title: title,
               text: text,
               image: image,
               user_id: user_id)
end
