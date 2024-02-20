class Admins::MembershipsController < AdminController
  def show
    # Retrieve all users and their memberships
    @users_with_memberships = User.includes(:memberships).all
  end

  def add_days
    user = User.find_by(id: params[:user_id]) || User.find_by(username: params[:user_id])

    if user.nil?
      flash[:error] = "User not found."
      redirect_back(fallback_location: root_path)
      return
    end

    # Find or create membership for the user
    membership = user.memberships.first_or_create

    # Handle nil days_of_membership
    membership.update(days_of_membership: 0) if membership.days_of_membership.nil?

    days_to_modify = params[:days].to_i

    # Check if the user wants to add or subtract days
    if params[:action_type] == "add"
      new_days = membership.days_of_membership + days_to_modify
      membership.update(days_of_membership: new_days)
      flash[:success] = "#{days_to_modify} days added successfully."
    elsif params[:action_type] == "subtract"
      new_days = [0, membership.days_of_membership - days_to_modify].max
      membership.update(days_of_membership: new_days)
      flash[:success] = "#{days_to_modify} days subtracted successfully."
    else
      flash[:error] = "Invalid action type."
    end

    redirect_back(fallback_location: root_path)
  end

end
