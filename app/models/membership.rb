class Membership < ApplicationRecord
  belongs_to :category
  monetize :price_cents
  has_many :orders, dependent: :destroy

  # Add the new attribute
  validates :days_of_membership, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
