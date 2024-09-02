json.extract! review, :id, :user_id, :rating, :comment, :display, :created_at, :updated_at
json.url review_url(review, format: :json)
