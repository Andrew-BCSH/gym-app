class RemoveWhatsappNumberFromUsers < ActiveRecord::Migration[7.0]
  def change
    # Temporarily disable foreign key constraints
    remove_foreign_key :users, column: :membership_id

    # Remove the whatsapp_number column
    remove_column :users, :whatsapp_number

    # Re-enable foreign key constraints
    add_foreign_key :users, :memberships
  end
end
