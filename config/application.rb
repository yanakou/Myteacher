require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myteacher
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.autoload_paths += Dir[Rails.root.join('app', 'uploaders')]   # この行を追加
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Don't generate system test files.
    config.generators.system_tests = nil

  #デフォルトの言語を日本語とし、英語対応も想定した設定とする。またタイムゾーンは東京をデフォルトにする。
  config.i18n.default_locale = :ja
  config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
  config.i18n.available_locales = [:en, :ja]
  config.time_zone = "Tokyo"

  # generatorを使う際に生成されるファイル
  config.generators do |generator|
    generator.test_framework :rspec,
                     fixtures: true,
             controller_specs: true,
                 helper_specs: false,
                routing_specs: false
    generator.fixture_replacement :factory_bot, dir: "spec/factories"
  end
  end
end
