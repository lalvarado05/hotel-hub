json.extract! room_service, :id, :room_id, :service_id, :created_at, :updated_at
json.url room_service_url(room_service, format: :json)
