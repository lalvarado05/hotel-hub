# frozen_string_literal: true

module Types
  class ReservationType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, Integer, null: false
    field :room_id, Integer, null: false
    field :check_in_date, GraphQL::Types::ISO8601Date
    field :check_out_date, GraphQL::Types::ISO8601Date
    field :status, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :confirmation_code, String

    field :room, Types::RoomType, null: false, description: "Reservation - Room asociation"

    def room
      object.room
    end
  end
end
