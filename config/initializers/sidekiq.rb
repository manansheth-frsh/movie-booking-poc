Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379/0' } # adjust if needed
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379/0' }
end

require 'sidekiq-cron'

schedule = {
  'daily_reminder_job' => {
    'cron' => '0 6 * * *',
    'class' => 'DailyReminderJob'
  }
}

Sidekiq::Cron::Job.load_from_hash(schedule)
