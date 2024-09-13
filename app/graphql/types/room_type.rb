# frozen_string_literal: true

module Types
  class RoomType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :price, Float
    field :available, Boolean
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false


  end
end
