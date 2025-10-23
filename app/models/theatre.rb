class Theatre < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :city, presence: true
  validates :capacity, presence: true

  has_many :shows, dependent: :delete_all

end
