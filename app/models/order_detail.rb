class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product
  belongs_to :payment
  # Validations
  validates :discount, presence: true
  validates :service_fee, presence: true

  delegate :name, to: :product, prefix: true
  delegate :name, to: :payment, prefix: true
  delegate :order_id, to: :order, prefix: true

  ## update the ransackable below with column you want to add ransack
  def self.ransackable_attributes(auth_object = nil)
    ["id"]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end