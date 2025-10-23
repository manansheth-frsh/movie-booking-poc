class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :show

  after_create :enqueue_post_booking_job

  private
  def enqueue_post_booking_job
    PostBookingJob.perform_later(self.id)
  end

end
