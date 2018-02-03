class Project < ApplicationRecord
  belongs_to :customer
  belongs_to :user
  has_many :activities, dependent: :restrict_with_error

  validates :name, presence: true
  validates :rate, presence: true
  validates :customer_id, presence: true
end
