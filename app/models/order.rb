class Order < ApplicationRecord
  belongs_to :user
  belongs_to :membership
  monetize :amount_cents
end
