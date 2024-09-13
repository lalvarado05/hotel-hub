# frozen_string_literal: true

module Types
  class ReviewType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, Integer, null: false
    field :rating, Integer
    field :comment, String
    field :display, Boolean
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :reservation_id, Integer, null: false
  end
end
