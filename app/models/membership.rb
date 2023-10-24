class Membership < ApplicationRecord
  belongs_to :category
  monetize :price_cents
  has_many :orders, dependent: :destroy
end
