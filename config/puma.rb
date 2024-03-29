# # ローカル設定
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count
port        ENV.fetch("PORT") { 3000 }
environment ENV.fetch("RAILS_ENV")  { ENV['RACK_ENV'] || "production" }
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }
workers ENV.fetch("WEB_CONCURRENCY") { 2 }
preload_app!
plugin :tmp_restart

# Docker使用設定
# threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }.to_i
# threads threads_count, threads_count
# port        ENV.fetch("PORT") { 3000 }
# environment ENV.fetch("RAILS_ENV") { "development" }
# plugin :tmp_restart
# app_root = File.expand_path("../..", __FILE__)
# bind "unix://#{app_root}/tmp/sockets/puma.sock"
# stdout_redirect "#{app_root}/log/puma.stdout.log", "#{app_root}/log/puma.stderr.log", true