class AddLastMembershipStartDateToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :last_membership_start_date, :date
  end
end
