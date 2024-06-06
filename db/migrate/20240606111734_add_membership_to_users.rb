class AddMembershipToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :membership, null: true, foreign_key: true
  end
end
