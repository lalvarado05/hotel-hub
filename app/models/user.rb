class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reservations, dependent: :destroy

  has_many :reviews, dependent: :destroy
  has_many :responses, dependent: :destroy

  # Validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true, format: { with: /\A\d{8}\z/, message: "must be 8 digits" }
  validates :role, presence: true, inclusion: { in: %w[admin client], message: "%{value} is not a valid role" }


end
