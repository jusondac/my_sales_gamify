class Supplier < ApplicationRecord
  # Associations
  has_many :products, dependent: :destroy
  belongs_to :user, optional: true

  # Validations
  validates :name, presence: true

  delegate :username, to: :user, prefix: true
  ## update the ransackable below with column you want to add ransack
  def self.ransackable_attributes(auth_object = nil)
    [ "id", "name", "created_at", "updated_at", "user_id", "phone_number", "product_count", "email" ]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
