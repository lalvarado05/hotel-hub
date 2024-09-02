class Response < ApplicationRecord
  belongs_to :user
  belongs_to :review

  validates :comment, presence: true, length: { maximum: 500 }
  validates :review_id, uniqueness: true  # Ensures each review can have only one response

end
