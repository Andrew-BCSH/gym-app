class AddFieldsToMemberships < ActiveRecord::Migration[7.0]
  def change
    add_monetize :memberships, :amount
    add_column :memberships, :option_sku, :string
    add_column :memberships, :state, :string
    add_column :memberships, :checkout_session_id, :string
    add_reference :memberships, :user, foreign_key: true
  end
end
