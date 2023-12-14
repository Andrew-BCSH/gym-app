class AddCreditAmountToReceipt < ActiveRecord::Migration[7.0]
  def change
    add_column :receipts, :credit_amount, :integer
  end
end
