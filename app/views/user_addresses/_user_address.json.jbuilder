json.extract! user_address, :id, :address_line, :address_line_2, :zip_code, :city, :state, :country, :user_id, :primary, :created_at, :updated_at
json.url user_address_url(user_address, format: :json)
