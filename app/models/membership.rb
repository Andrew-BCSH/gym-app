class Membership < ApplicationRecord
  belongs_to :category
  belongs_to :user, optional: true
  monetize :price_cents
  has_many :orders, dependent: :destroy

  validates :days_of_membership, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :name, presence: true
  validates :category, presence: true
end
