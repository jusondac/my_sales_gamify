json.extract! product, :id, :name, :price, :category_id, :supplier_id, :created_at, :updated_at
json.url product_url(product, format: :json)
