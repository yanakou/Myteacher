# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# rootへのルーティング作成 Herokuでアプリケーションにアクセスした時、最初に開くページをRails側で設定する
config.assets.compile = true
config.assets.initialize_on_precompile=false