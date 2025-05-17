json.extract! order_detail, :id, :order_id, :product_id, :payment_id, :discount, :service_fee, :created_at, :updated_at
json.url order_detail_url(order_detail, format: :json)
