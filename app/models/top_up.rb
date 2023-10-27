# app/models/top_up.rb
class TopUp < ApplicationRecord
  monetize :amount_cents, as: :top_up_amount
  belongs_to :user
end
