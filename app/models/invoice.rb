class Invoice < ApplicationRecord
  belongs_to :user
  belongs_to :user_address
  belongs_to :customer_address
  belongs_to :customer
  has_many :activities, dependent: :restrict_with_error

  validates :user, presence: true
  validates :customer, presence: true
  validates :user_address, presence: true
  validates :customer_address, presence: true
  validates :total_cost, presence: true
  validates :date, presence: true
end
