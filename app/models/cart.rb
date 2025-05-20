class Cart < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :user
  has_many  :cart_details
  has_many  :products, through: :cart_details
  has_many  :suppliers, through: :products
  has_many  :categories, through: :products
  has_many  :orders, through: :cart_details
  has_many  :order_details, through: :orders
  # Validations
  validates :status, presence: true

  enum :status, {
    active: 0,
    archived: 1
  }

  ## update the ransackable below with column you want to add ransack
  def self.ransackable_attributes(auth_object = nil)
    [ "id" ]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
