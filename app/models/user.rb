class User < ApplicationRecord
  has_secure_password

  has_many :customers
  has_many :projects

  validates_uniqueness_of :email
end
