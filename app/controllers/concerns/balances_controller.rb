class BalancesController < ApplicationController
  before_action :authenticate_user!

  def show
    user_credit = current_user.credit
    @user_balance = user_credit.present? ? user_credit.balance : 0
  end
end
