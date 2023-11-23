class AddColumnsToMejiroCoinTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :mejiro_coin_transactions, :username, :string
    add_column :mejiro_coin_transactions, :product, :string
    add_column :mejiro_coin_transactions, :date, :date
    add_column :mejiro_coin_transactions, :spend, :decimal
    add_column :mejiro_coin_transactions, :time, :time
  end
end
