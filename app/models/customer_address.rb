class CustomerAddress < ApplicationRecord
  belongs_to :customer
  has_many :invoices, dependent: :restrict_with_error
end
