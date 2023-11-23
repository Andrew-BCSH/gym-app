class AddUserIdToMemberships < ActiveRecord::Migration[6.0]
  def change
    add_reference :memberships, :user, foreign_key: true, index: true
  end
end
