class Inventory < ApplicationRecord
  belongs_to :product
  # Validations
  validates :stock, presence: true

  ## update the ransackable below with column you want to add ransack
  def self.ransackable_attributes(auth_object = nil)
    ["id"]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end