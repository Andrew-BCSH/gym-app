class AddAmountToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :amount_cents, :integer
    add_column :orders, :amount_currency, :string
  end
end
