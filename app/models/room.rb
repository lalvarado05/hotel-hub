class Room < ApplicationRecord
  has_many :room_services
  has_many :services, through: :room_services

  has_many :room_beds
  has_many :beds, through: :room_beds

  has_many :reservations, dependent: :destroy

  has_one_attached :image
  
end
