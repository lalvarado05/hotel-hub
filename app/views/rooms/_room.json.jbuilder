json.extract! room, :id, :name, :price, :available, :created_at, :updated_at
json.url room_url(room, format: :json)
