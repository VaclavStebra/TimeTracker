class Customer < ApplicationRecord
  belongs_to :user
  has_many :projects, dependent: :restrict_with_error
  has_many :activities, dependent: :restrict_with_error
  has_many :customer_addresses, dependent: :nullify

  validates :name, presence: true
  validates :address_line, presence: true
  validates :zip_code, presence: true
  validates :city, presence: true
  validates :country, presence: true
end
