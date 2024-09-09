class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :user_id, :room_id, presence: true
  validates :check_in_date, :check_out_date, presence: true
  validates :status, presence: true, inclusion: { in: %w[booked checked_in checked_out canceled] }
  validates :confirmation_code, presence: true, uniqueness: true

end
