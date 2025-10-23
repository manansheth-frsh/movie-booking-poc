class Movie < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :language, presence: true
  validates :release_date, presence: true

  has_many :shows, dependent: :delete_all
end
