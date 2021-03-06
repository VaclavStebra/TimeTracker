class User < ApplicationRecord
  has_secure_password

  has_many :customers, dependent: :restrict_with_error
  has_many :projects, dependent: :restrict_with_error
  has_many :activities, dependent: :restrict_with_error
  has_many :user_addresses, dependent: :restrict_with_error
  has_many :invoices, dependent: :restrict_with_error

  validates_uniqueness_of :email
end
