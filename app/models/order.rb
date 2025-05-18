class Order < ApplicationRecord
  belongs_to :user
  # Validations
  validates :amount, presence: true
  validates :status, presence: true
  validates :ordered_at, presence: true

  has_many :order_details, dependent: :destroy

  scope :total_amount, -> { sum(:amount) }

  delegate :username, to: :user, prefix: true

  before_validation :set_order_id

  broadcasts_refreshes

  # Enum for status
  # This will create a mapping for the status column
  # and also create methods like `order.pending?`, `order.completed?`, etc.
  # It will also create scopes like `Order.pending`, `Order.completed`, etc.
  # You can customize the enum values as per your requirement
  # For example, you can use strings instead of integers
  # enum status: { pending: 'pending', completed: 'completed', cancelled: 'cancelled' }

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
