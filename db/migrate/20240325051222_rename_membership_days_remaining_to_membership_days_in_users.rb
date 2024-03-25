class RenameMembershipDaysRemainingToMembershipDaysInUsers < ActiveRecord::Migration[7.0]
  def up
    rename_column :users, :membership_days_remaining, :membership_days
  end

  def down
    rename_column :users, :membership_days, :membership_days_remaining
  end
end
