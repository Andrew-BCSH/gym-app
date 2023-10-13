class NavbarController < ApplicationController
  before_action :set_user_credit

  def set_user_credit
    @user_credit = current_user.credit.balance if user_signed_in?
  end
end
