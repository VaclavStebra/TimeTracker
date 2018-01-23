class UserAddress < ApplicationRecord
  belongs_to :user

  validates :address_line, presence: true
  validates :zip_code, presence: true
  validates :city, presence: true
  validates :country, presence: true
end
