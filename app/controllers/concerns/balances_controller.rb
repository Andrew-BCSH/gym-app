class BalancesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user_balance = current_user.credit.balance
  end

end
