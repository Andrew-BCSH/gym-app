# app/controllers/admin/memberships_controller.rb
class Admins::MembershipsController < AdminController

  def show
    # Retrieve all users and their memberships
    @users_with_memberships = User.includes(:memberships).all
  end

  def add_days
    membership = Membership.find(params[:membership_id])
    days_to_add = params[:days_to_add].to_i

    # Add logic to update membership days here
    membership.update(days_of_membership: membership.days_of_membership + days_to_add)

    respond_to do |format|
      format.json { render json: { id: membership.id, days_of_membership: membership.days_of_membership } }
    end
  end

end
