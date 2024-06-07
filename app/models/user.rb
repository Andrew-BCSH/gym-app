class User < ApplicationRecord
  has_one :credit, dependent: :destroy
  has_many :membership_logs
  has_many :memberships
  has_many :top_ups, dependent: :destroy

  belongs_to :membership, optional: true

  after_create :initialize_user_credit

  def initialize_user_credit
    Credit.create(user: self, balance: 0)
  end

  def top_up_balance(amount_in_currency)
    credit = self.credit
    if credit
      credit.update(balance: credit.balance + amount_in_currency)
    else
      # Handle the case where there's no credit record for the user
    end
  end

  def membership_days_remaining
    total_remaining_days = 0
    if last_membership_start_date
      total_remaining_days = [0, (last_membership_start_date + membership_days - Date.today).to_i].max
    end
    total_remaining_days
  end

  def membership_name
    memberships.last&.name
  end

  def qr_code_data
    {
      user_id: id,
      mejiro_coin_balance: credit&.balance || 0,
      membership_name: membership_name # Include the membership name
    }
  end

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  validates :username, presence: true, uniqueness: true
end
