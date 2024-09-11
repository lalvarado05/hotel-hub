class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_one :review

  validates :user_id, :room_id, presence: true
  validates :check_in_date, :check_out_date, presence: true
  validates :status, presence: true, inclusion: { in: %w[booked checked_in checked_out no_show cancelled] }
  validates :confirmation_code, presence: true, uniqueness: true


  scope :checked_out, -> { where(status: 'checked_out') }
  def can_leave_review?
    status == 'checked_out' && review.nil?
  end
end


