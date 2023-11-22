# app/models/admin.rb
class Admin < ApplicationRecord
  validates :admin_name, presence: true
  # Add any other validations or associations here

  # Include Devise modules and custom attributes
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [:admin_name]
end
