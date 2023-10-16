class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # app/models/user.rb
  # app/models/user.rb
  has_one :credit, dependent: :destroy


  after_create :initialize_user_credit

  # Other user model code...

  private

  def initialize_user_credit
    # Create a Credit record for the user with an initial balance of 0 Mejiro Coins
    Credit.create(user: self, balance: 0)
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, presence: true, uniqueness: true
end
