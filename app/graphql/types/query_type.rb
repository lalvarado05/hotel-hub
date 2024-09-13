module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Example field added by generator
    field :test_field, String, null: false, description: "An example field added by the generator"

    def test_field
      "Hello World!"
    end

    # Correct users query
    field :users, [Types::UserType], null: false, description: "Returns a list of users"

    def users
      User.all
    end

    field :users_with_reservations, [Types::UserType], null: false, description: "Fetch all users and their reservations"

    def users_with_reservations
      User.includes(:reservations).all
    end

    field :user, Types::UserType, null: false do
      argument :id, ID, required: true
    end

    def user(id:)
      User.find(id)
    end

    field :room, Types::RoomType, null: false do
      argument :id, ID, required: true
    end

    def room(id:)
      Room.find(id)
    end

    field :reservation, Types::ReservationType, null: false do
      argument :id, ID, required: true
    end

    def reservation(id:)
      Reservation.find(id)
    end
  end
end