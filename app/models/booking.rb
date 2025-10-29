class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :show

  after_commit :enqueue_post_booking_job, :update_seats_left
  AVAILABLE_SEATS_CACHE = Rails.application.config.cache_config[:SHOWS_AVAILABLE]

  private
  def enqueue_post_booking_job
    PostBookingJob.perform_later(self.id)
  end

  def update_seats_left
    thisBooking = Booking.find(self.id)
    puts "update number of seats ", self.id, thisBooking.show.id, self.seats
    $redis.decrby("#{AVAILABLE_SEATS_CACHE}_#{thisBooking.show.id}", self.seats)

  end


end
