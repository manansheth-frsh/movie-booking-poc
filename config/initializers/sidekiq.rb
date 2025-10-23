Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379/0' } # adjust if needed
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379/0' }
end

