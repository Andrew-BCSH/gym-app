module ApplicationHelper
  def credit
    if user_signed_in?
      Credit.find(current_user.id)
    end
  end
end
