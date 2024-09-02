class Bed < ApplicationRecord
  has_many :room_beds
  has_many :rooms, through: :room_beds
end
