class Show < ApplicationRecord
  belongs_to :movie
  belongs_to :theatre
  has_many :bookings, dependent: :delete_all
  delegate :seats, to: :bookings

  validates :slot, presence: true, inclusion: { in: [1, 2, 3, 4] }
  validates :date, presence: true
  validates :current_available_bookings, presence: true, numericality: { greater_than_or_equal_to: 0 }

  # Uniqueness constraint: same movie, theatre, slot, date combination
  validates :slot, uniqueness: { scope: [:theatre_id, :date], message: "already allocated for this date in this theatre" }

  before_validation :set_default_bookings, on: :create
  after_create :initialize_redis_seat_count
  private
  AVAILABLE_SEATS_CACHE = Rails.application.config.cache_config[:SHOWS_AVAILABLE]
  def set_default_bookings
    if self.current_available_bookings.nil? && theatre.present?
      self.current_available_bookings = theatre.capacity
    end
  end

  def initialize_redis_seat_count
    puts "Add to redis ", current_available_bookings
    # $redis.set("show_available_seats#{id}": current_available_bookings)
    $redis.set("#{AVAILABLE_SEATS_CACHE}_#{id}", current_available_bookings)
  end
end
