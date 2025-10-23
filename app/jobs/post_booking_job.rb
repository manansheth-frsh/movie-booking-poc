# app/jobs/post_booking_job.rb
class PostBookingJob < ApplicationJob
  queue_as :default

  def perform(booking_id)
    Rails.logger.info "Sidekiq worker processing PostBookingJob with PID: #{Process.pid}"
    puts "Sidekiq worker processing PostBookingJob with PID: #{Process.pid}"

    # Dummy work for now
    sleep 5
    puts "Sending email now"
    UserMailer.booking_confirmation(@user, @booking).deliver_now
    Rails.logger.info "Finished PostBookingJob for booking_id: #{booking_id}"
  end
end
