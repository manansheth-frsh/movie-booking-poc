class DailyReminderJob < ApplicationJob
  queue_as :default

  def perform
    Rails.logger.info "Running DailyReminderJob at #{Time.now} (PID: #{Process.pid})"

    today = Date.current
    bookings = Booking.includes(:user, :show).where(shows: {date: today})
    bookings.each do |booking|
      puts "Send reminder email", booking.user, booking
      UserMailer.reminder_email(booking.user, booking).deliver_later
    end
  end
end
