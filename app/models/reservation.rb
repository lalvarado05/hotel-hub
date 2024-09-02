class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :check_in_date, :check_out_date, presence: true
  validates :status, presence: true, inclusion: { in: %w[booked checked_in checked_out canceled] }
end
