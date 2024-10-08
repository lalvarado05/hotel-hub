# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :first_name, String, null: false
    field :last_name, String, null: false
    field :phone_number, String, null: false
    field :role, String, null: false
    field :email, String, null: false
    field :encrypted_password, String, null: false
    field :reset_password_token, String
    field :reset_password_sent_at, GraphQL::Types::ISO8601DateTime
    field :remember_created_at, GraphQL::Types::ISO8601DateTime
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :user_name, String, null: false

    field :reservations, [Types::ReservationType], null: false, description: "Reservations for the user"


    def user_name
      "First name: #{object.first_name} Last name: #{object.last_name}"
    end
    def reservations
      object.reservations
    end

  end


end
