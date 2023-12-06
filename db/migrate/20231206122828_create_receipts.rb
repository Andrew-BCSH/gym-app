class CreateReceipts < ActiveRecord::Migration[7.0]
  def change
    create_table :receipts do |t|
      t.integer :product_id
      t.string :product_name
      t.float :product_price
      t.string :product_category
      t.integer :user_id
      t.float :user_post_balance
      t.timestamp :timestamp

      t.timestamps
    end
  end
end
