source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3'

# LESSをSassに変換する
gem 'bootstrap-sass', '3.4.1'

gem 'dotenv-rails'

# パスワードをハッシュ化するための関数
gem 'bcrypt', '3.1.13'

# ユーザー名をランダムに作成する
gem 'faker', '2.1.2'

# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.4.4'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # Rspec
  gem 'rspec-rails'
  # factory_bot (テストデータ作成ツール)の導入
  gem 'factory_bot_rails'
  # render_templateを使うために必要
  gem 'rails-controller-testing'
end

group :test do
  # capybaraを導入
  gem 'capybara'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '~> 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # rubocop
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  # capistranoの導入
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano3-unicorn'
end

group :production do
end

group :production, :staging do
  gem 'unicorn'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# pagination機能
gem 'kaminari'

# 画像アップロード
gem 'carrierwave'

# 画像のリサイズ
gem 'mini_magick'

# タグ付け機能
gem 'acts-as-taggable-on', '~> 6.0'

# Tag-it(タグ付けのUIを提供するjQueryプラグイン)
gem 'jquery-ui-rails'

# controller内での変数をjavascript内で使用可能にする
gem 'gon'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
