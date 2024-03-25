class AddMembershipDaysRemainingToMemberships < ActiveRecord::Migration[7.0]
  def change
    add_column :memberships, :membership_days_remaining, :integer
  end
end
