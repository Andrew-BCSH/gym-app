class Admins::MembershipsController < AdminController
  def index
    @users_with_memberships = User.all.order(sort_column + ' ' + sort_direction)
  end

  def show
    # Retrieve all users and their memberships
    @users_with_memberships = User.all.order(sort_column + ' ' + sort_direction)
  end


  def add_days
    user = User.find_by(id: params[:user_id])
    membership = Membership.find_by(id: params[:membership_id])

    if user.nil?
      flash[:error] = "User not found."
    else
      order_amount = params[:order_amount].to_i
      days_remaining = user.membership_days || 0
      days_to_modify = 0

      if membership.sku == "daily"
        days_to_modify += params[:order_amount].to_i
      elsif membership.sku == "monthly"
        days_to_modify += params[:order_amount].to_i * 30
      elsif membership.sku == "yearly"
        days_to_modify += params[:order_amount].to_i * 365
      end

      if params[:action_type] == "add"
        new_days = days_remaining + days_to_modify
      elsif params[:action_type] == "subtract"
        new_days = [0, days_remaining - days_to_modify].max
      else
        flash[:error] = "Invalid action type."
        redirect_to admins_memberships_show_path and return
      end

      membership_log = user.membership_logs.create
      membership_log.membership_id = params[:membership_id]
      membership_log.amount = params[:order_amount].to_i
      membership_log.total_cost = params[:total_cost].to_i
      membership_log.operation = params[:action_type]
      if user.membership_days_remaining ==0
        user.last_membership_start_date =DateTime.now
      end

      user.membership_days =new_days

      if user.save()
        membership_log.save!
        flash[:success] = "#{days_to_modify} days #{params[:action_type]}ed successfully."
      else
        flash[:error] = "Failed to #{params[:action_type]} days."
      end
    end

    # respond_to do |format|
    #   format.turbo_stream
    # end

    redirect_to admins_show_membership_path
  end

  private

  def sort_column
    params[:sort] || 'username'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end
