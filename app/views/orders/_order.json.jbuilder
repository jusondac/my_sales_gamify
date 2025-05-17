json.extract! order, :id, :order_id, :amount, :status, :user_id, :ordered_at, :created_at, :updated_at
json.url order_url(order, format: :json)
