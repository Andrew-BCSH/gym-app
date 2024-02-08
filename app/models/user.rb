# app/models/user.rb
class User < ApplicationRecord
  # Include default devise modules.
  # Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, and :omniauthable
  has_one :credit, dependent: :destroy
  has_many :orders
  has_many :memberships

  after_create :initialize_user_credit

  def initialize_user_credit
    # Create a Credit record for the user with an initial balance of 0 Mejiro Coins
    Credit.create(user: self, balance: 0)
  end

  # Method to update user's balance
  def top_up_balance(amount_in_currency)
    credit = self.credit
    if credit
      # Update the balance by adding the top-up amount
      credit.update(balance: credit.balance + amount_in_currency)
    else
      # Handle the case where there's no credit record for the user
      # You can create one or handle it as per your application logic
    end
  end

  def qr_code_data
    # Define the data you want to include in the QR code for the user
    qr_data = {
      user_id: id,
      mejiro_coin_balance: credit&.balance || 0,
      # Add more data as needed
    }

    # Convert the data to a JSON string
    qr_data.to_json
  end

  # Other user model code...

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  validates :username, presence: true, uniqueness: true
end
