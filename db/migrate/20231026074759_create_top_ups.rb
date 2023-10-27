class CreateTopUps < ActiveRecord::Migration[7.0]
  def change
    create_table :top_ups do |t|
      t.string :state
      t.integer :amount_cents
      t.string :amount_currency
      t.string :checkout_session_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
