class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.float :price
      t.boolean :in_stock
      t.string :price_currency
      t.string :category

      t.timestamps
    end
  end
end
