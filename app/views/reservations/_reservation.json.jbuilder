json.extract! reservation, :id, :user_id, :room_id, :check_in_date, :check_out_date, :status, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
