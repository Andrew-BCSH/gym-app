class CreateOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :options do |t|
      t.string :sku
      t.string :name
      t.references :membership, null: false, foreign_key: true
      t.string :photo_url

      t.timestamps
    end
  end
end
