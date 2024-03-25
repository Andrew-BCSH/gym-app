class AddMembershipDaysRemainingToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :membership_days_remaining, :integer
  end
end
