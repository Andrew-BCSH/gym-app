class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, and :omniauthable
  has_one :credit, dependent: :destroy
  has_many :membership_logs
  has_many :memberships, dependent: :destroy
  has_many :top_ups, dependent: :destroy

  after_create :initialize_user_credit

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true

  def initialize_user_credit
    Credit.create(user: self, balance: 0)
  end

  def top_up_balance(amount_in_currency)
    if credit
      credit.update(balance: credit.balance + amount_in_currency)
    end
  end

  def membership_days_remaining
    if last_membership_start_date
      [0, (last_membership_start_date + membership_days - Date.today).to_i].max
    else
      0
    end
  end

  def membership_name
    memberships.last&.name
  end

  def qr_code_data
    {
      user_id: id,
      mejiro_coin_balance: credit&.balance || 0,
    }
  end
end
