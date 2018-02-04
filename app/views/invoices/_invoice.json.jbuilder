json.extract! invoice, :id, :user_id, :user_address_id, :customer_address_id, :date, :total_cost, :customer_id, :created_at, :updated_at
json.url invoice_url(invoice, format: :json)
