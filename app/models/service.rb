class Service < ApplicationRecord
  has_many :room_services
  has_many :rooms, through: :room_services
end
