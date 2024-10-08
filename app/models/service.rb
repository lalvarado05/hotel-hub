class Service < ApplicationRecord
  has_many :room_services
  has_many :rooms, through: :room_services

  #validations
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

end
