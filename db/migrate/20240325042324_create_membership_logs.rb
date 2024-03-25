class CreateMembershipLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :membership_logs do |t|
      t.integer :user_id
      t.integer :membership_id
      t.integer :amount
      t.integer :total_cost
      t.string :operation

      t.timestamps
    end
  end
end
