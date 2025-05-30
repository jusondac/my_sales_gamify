class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :suppliers
  has_many :carts

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  enum :role, { user: 0, supplier: 1, admin: 2 }
end
