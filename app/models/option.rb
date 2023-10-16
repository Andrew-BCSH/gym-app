class Option < ApplicationRecord
  belongs_to :membership
  monetize :price_cents, as: "price"

end
