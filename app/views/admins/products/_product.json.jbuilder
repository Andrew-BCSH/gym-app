json.extract! product, :id, :name, :price, :in_stock, :price_currency, :category, :created_at, :updated_at
json.url product_url(product, format: :json)
