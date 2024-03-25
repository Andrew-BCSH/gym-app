class RemoveMembershipDaysRemainingFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :membership_days_remaining, :integer
  end
end
