class Review < ApplicationRecord
  belongs_to :user
  has_one :response, dependent: :destroy # Each review only gets one response from the hotel Admins
  belongs_to :reservation

  # Validations
  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :comment, presence: true, length: { maximum: 500 }
  validates_uniqueness_of :reservation_id


end
