class Admins::MembershipsController < AdminController
  def index
    @users_with_memberships = User.all.order(sort_column + ' ' + sort_direction)
  end

  def show
    # Retrieve all users and their memberships
    @users_with_memberships = User.all.order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)
  end

  # Controller action
  def new
    @membership = Membership.new
    @memberships = Membership.all
  end


  def create
    @membership = Membership.new(membership_params)
    if @membership.save
      flash[:success] = "Membership created successfully."
      redirect_to admins_memberships_path
    else
      flash[:error] = "Failed to create membership."
      render :new
    end
  end

  def membership_params
    params.require(:membership).permit(:name, :sku, :category_id, :price_cents, :days_of_membership)
  end

    def add_or_remove_membership_types
      if params[:action_type] == "add"
        # Logic to add a new membership type
        membership_params = {
          sku: params[:sku],
          name: params[:name],
          category: params[:category],
          price_cents: params[:price_cents],
          days_of_membership: params[:days_of_membership]
        }
        @membership = Membership.new(membership_params)

        if @membership.save
          flash[:success] = "Membership type added successfully."
        else
          flash[:error] = "Failed to add membership type."
        end
      elsif params[:action_type] == "remove"
        # Logic to remove an existing membership type
        membership = Membership.find_by(id: params[:membership_id])
        if membership.present?
          membership.destroy
          flash[:success] = "Membership type removed successfully."
        else
          flash[:error] = "Membership type not found."
        end
      end

      redirect_to admins_show_membership_path

    end


    def add_days
      user = User.find_by(id: params[:user_id])
      membership = Membership.find_by(id: params[:membership_id])

      if user.nil?
        flash[:error] = "User not found."
        redirect_to admins_memberships_show_path and return
      end

      if membership.nil?
        flash[:error] = "Membership not found."
        redirect_to admins_memberships_show_path and return
      end

      days_remaining = user.membership_days || 0
      days_to_modify = 0

      case membership.sku
      when "daily"
        days_to_modify += params[:order_amount].to_i
      when "monthly"
        days_to_modify += params[:order_amount].to_i * 30
      when "yearly"
        days_to_modify += params[:order_amount].to_i * 365
      end

      new_days = if params[:action_type] == "add"
                   days_remaining + days_to_modify
                 elsif params[:action_type] == "subtract"
                   [0, days_remaining - days_to_modify].max
                 else
                   flash[:error] = "Invalid action type."
                   redirect_to admins_memberships_show_path and return
                 end

      membership_log = user.membership_logs.create(
        membership_id: params[:membership_id],
        amount: params[:order_amount].to_i,
        total_cost: params[:total_cost].to_i,
        operation: params[:action_type]
      )

      user.last_membership_start_date = DateTime.now if user.membership_days_remaining == 0
      user.membership_days = new_days

      if user.memberships.exclude?(membership)
        user.memberships << membership
      end

      if user.save
        membership_log.save!
        flash[:success] = "#{days_to_modify} days #{params[:action_type]}ed successfully."
      else
        flash[:error] = "Failed to #{params[:action_type]} days."
      end

      redirect_to admins_show_membership_path(user_id: user.id)
    end




  private

  def sort_column
    params[:sort] || 'username'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end
