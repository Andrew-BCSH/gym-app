class AddDaysOfMembershipToMemberships < ActiveRecord::Migration[7.0]
  def change
    add_column :memberships, :days_of_membership, :integer
  end
end
