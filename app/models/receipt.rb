class Receipt < ApplicationRecord
  belongs_to :user
  attribute :credit_amount, :integer
end
