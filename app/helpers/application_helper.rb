module ApplicationHelper
  def credit
    if user_signed_in?
      Credit.find(current_user.id)
    end
  end

  def sort_link(column, label)
    direction = column == params[:sort] && params[:direction] == 'asc' ? 'desc' : 'asc'
    icon = direction == 'asc' ? '▲' : '▼'
    link_to "#{label} #{icon}".html_safe, { sort: column, direction: direction }
  end
end
