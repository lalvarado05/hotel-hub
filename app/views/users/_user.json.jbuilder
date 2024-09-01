json.extract! user, :id, :first_name, :last_name, :phone_number, :role, :email, :created_at, :updated_at
json.url user_url(user, format: :json)
