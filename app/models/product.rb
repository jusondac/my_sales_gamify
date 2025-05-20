class Product < ApplicationRecord
  belongs_to :category
  belongs_to :supplier
  # Validations
  validates :name, presence: true
  validates :price, presence: true

  delegate :name, to: :category, prefix: true
  delegate :name, to: :supplier, prefix: true

  def in_carts?(cart)
    !cart.cart_details.where(product: self).exists?
  end


  ## update the ransackable below with column you want to add ransack
  def self.ransackable_attributes(auth_object = nil)
    [ "id" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "supplier", "category" ]
  end
end
