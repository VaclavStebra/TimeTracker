class User < ApplicationRecord
  has_secure_password

  has_many :customers

  validates_uniqueness_of :email
end
