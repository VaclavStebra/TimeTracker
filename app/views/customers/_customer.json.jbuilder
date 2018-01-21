json.extract! customer, :id, :name, :address_line, :address_line_2, :zip_code, :city, :state, :country, :created_at, :updated_at
json.url customer_url(customer, format: :json)
