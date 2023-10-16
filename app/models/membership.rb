class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :option
  monetize :amount_cents
end
