class Order < ApplicationRecord
  belongs_to :user
  # Validations
  validates :amount, presence: true
  validates :status, presence: true
  validates :ordered_at, presence: true

  before_validation :set_order_id

  broadcasts_refreshes

  enum :status, {
    pending: 0,
    completed: 1,
    cancelled: 2
  }

  def set_order_id
    self.order_id = "ORDER-#{SecureRandom.hex(5).upcase}"
  end

  ## update the ransackable below with column you want to add ransack
  def self.ransackable_attributes(auth_object = nil)
    [ "id" ]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
