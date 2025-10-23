class Show < ApplicationRecord
  belongs_to :movie
  belongs_to :theatre
  has_many :bookings, dependent: :delete_all # <-- ADD THIS LINE

  validates :slot, presence: true, inclusion: { in: [1, 2, 3, 4] }
  validates :date, presence: true
  validates :current_available_bookings, presence: true, numericality: { greater_than_or_equal_to: 0 }

  # Uniqueness constraint: same movie, theatre, slot, date combination
  validates :slot, uniqueness: { scope: [:theatre_id, :date], message: "already allocated for this date in this theatre" }
  # validates :slot, uniqueness: { scope: [:theatre_id, :date], message: "for this theatre, and date , show already exists" }

  # Set default for current_available_bookings based on theatre capacity
  before_validation :set_default_bookings, on: :create

  private

  def set_default_bookings
    if self.current_available_bookings.nil? && theatre.present?
      self.current_available_bookings = theatre.capacity
    end
  end
end
