# app/models/user.rb
class User < ApplicationRecord
  # Include default devise modules.
  # Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, and :omniauthable
  has_one :credit, dependent: :destroy
  has_many :membership_logs
  has_many :memberships

  after_create :initialize_user_credit
  # after_create :set_last_membership_start_date


  def initialize_user_credit
    # Create a Credit record for the user with an initial balance of 0 Mejiro Coins
    Credit.create(user: self, balance: 0)
  end

  # def set_last_membership_start_date
  #   update(last_membership_start_date: Date.today)
  # end

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

  def membership_days_remaining
    total_remaining_days = 0
    if last_membership_start_date
      total_remaining_days = [0, (last_membership_start_date + membership_days - Date.today).to_i].max
    end
    total_remaining_days
  end

  # def last_membership_start_date
  #   # Logic to fetch the last membership start date
  # end

  def membership_sku
    memberships.last&.sku
  end


  def qr_code_data
    # Define the data you want to include in the QR code for the user
    {
      user_id: id,
      mejiro_coin_balance: credit&.balance || 0,
      # Add more data as needed
    }
  end

  # Other user model code...

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  validates :username, presence: true, uniqueness: true
end
