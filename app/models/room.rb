class Room < ApplicationRecord
  has_many :room_services , dependent: :destroy
  has_many :services, through: :room_services

  has_many :room_beds , dependent: :destroy
  has_many :beds, through: :room_beds

  has_many :reservations, dependent: :destroy
  has_many :reviews, through: :reservations

  has_one_attached :image

    # Validations
    validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 50 }
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :available, inclusion: { in: [true, false] }
    validates :beds, presence: true
    validates :services, presence: true
    validates :image, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg'], size: { less_than: 5.megabytes }

    # Custom validation for price
    validate :reasonable_price


    def capacity
      beds.sum(:capacity)
    end
    def average_rating
      if reviews.any?
        reviews.average(:rating).to_f.round(1)
      else
        0
      end
    end
    private

    def reasonable_price
      if price.present? && price > 10000
        errors.add(:price, "is too high, please provide a reasonable price")
      end
    end




end
