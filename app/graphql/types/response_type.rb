# frozen_string_literal: true

module Types
  class ResponseType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, Integer, null: false
    field :review_id, Integer, null: false
    field :comment, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
