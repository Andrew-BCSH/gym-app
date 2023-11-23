class CreateMejiroCoinTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :mejiro_coin_transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :spend_amount
      t.string :product_name

      t.timestamps
    end
  end
end
